//
//  CocktailListView.swift
//  TheMeal
//
//  Created by Thomas Brossard on 9/27/24.
//

import Foundation
import SwiftUI

struct CocktailListView: View {
    @ObservedObject var viewModel: CocktailListViewModel
    @State private var searchText: String = ""
    @State private var selectedCategory: String = "Cocktail"

    // List of categories
    let categories = [
        "Cocktail", "Ordinary Drink", "Punch / Party Drink",
        "Shake", "Other / Unknown", "Cocoa", "Shot",
        "Coffee / Tea", "Homemade Liqueur", "Beer", "Soft Drink"
    ]
    
    let requests = [
        "Cocktail", "Ordinary_Drink", "Punch_/_Party_Drink",
        "Shake", "Other_/_Unknown", "Cocoa", "Shot",
        "Coffee_/_Tea", "Homemade_Liqueur", "Beer", "Soft_Drink"
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("🍸 GlouGlou Time 🍸")
                    .frame(alignment: .center)
                
                TextField("Search for a cocktail...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Picker("Select a category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(height: 50)

                
                List(filteredCocktails) { cocktail in
                    NavigationLink(destination: DrinkView(drink_id: cocktail.idDrink, viewModel: DrinkViewModel())) {
                        HStack(alignment: .center) {
                            AsyncImage(url: URL(string: cocktail.strDrinkThumb)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView().progressViewStyle(.circular)
                            }
                            .frame(width: 75, height: 75)
                            Text(cocktail.strDrink)
                        }
                    }
                }
            }
            .navigationTitle("")
            .onAppear {
                viewModel.list.removeAll()
                fetchCocktailsForSelectedCategory()
            }
            .onChange(of: selectedCategory) { _ in
                viewModel.list.removeAll()
                searchText = ""
                fetchCocktailsForSelectedCategory()
            }
        }
    }
    
    private func fetchCocktailsForSelectedCategory() {
        if let index = categories.firstIndex(of: selectedCategory) {
            viewModel.fetchData(cocktail_category: requests[index])
        }
    }
    
    private var filteredCocktails: [CocktailDataIdentifiable] {
        if searchText.isEmpty {
            return viewModel.list
        } else {
            return viewModel.list.filter {
                $0.strDrink.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

