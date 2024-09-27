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

    var body: some View {
        VStack {
            Text("🍸 CocktailTime 🍸")
                .frame(alignment: .center)
            
            TextField("Search for a cocktail...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            List(filteredCocktails) { cocktail in
                NavigationLink(destination: CocktailDetailView(cocktail: cocktail)) {
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
        .navigationTitle("Cocktails")
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
