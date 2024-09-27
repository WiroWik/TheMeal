//
//  MealListView.swift
//  TheMeal
//
//  Created by Thomas Brossard on 9/13/24.
//

import Foundation
import SwiftUI

struct MealListView: View {
    @ObservedObject var viewModel: MealListViewModel
    @State private var searchText: String = ""
    @State private var selectedCountry: String = "France"

    // List of countries
    let countries = [
        "Canada", "Chine", "Croatie", "Egypte", "Espagne", "États-Unis",
        "France", "Grece", "Irlande", "Inde", "Italie", "Jamaïque",
        "Japon", "Malaisie", "Maroc", "Mexique", "Pays-Bas",
        "Philippines", "Pologne", "Portugal", "Royaume Uni", "Russie",
        "Saint-Christophe-et-Niévès", "Slovaquie", "Thailande",
        "Tunisie", "Turquie", "Ukraine", "Vietnam"
    ]
    
    let nationalities = [
        "Canadian", "Chinese", "Croatian", "Egyptian", "Spanish", "American",
        "French", "Greek", "Irish", "Indian", "Italian", "Jamaican",
        "Japanese", "Malaysian", "Moroccan", "Mexican", "Dutch",
        "Filipino", "Polish", "Portuguese", "British", "Russian",
        "Kenyan", "Slovak", "Thai",
        "Tunisian", "Turkish", "Ukrainian", "Vietnamese"
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text("😋 MiamMiamTime 😋")
                    .frame(alignment: .center)

                // Search TextField
                TextField("Search for a meal...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Country Picker
                Picker("Select a country", selection: $selectedCountry) {
                    ForEach(countries, id: \.self) { country in
                        Text(country).tag(country)
                    }
                }
                .pickerStyle(MenuPickerStyle()) // Use a dropdown style
                .frame(height: 50)
                .padding()
                
                List(filteredMeals) { meal in
                    NavigationLink(destination: DishView(dish_id: meal.idMeal, viewModel: DishViewModel())) {
                        HStack(alignment: .center) {
                            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView().progressViewStyle(.circular)
                            }
                            .frame(width: 75, height: 75)
                            Text(meal.strMeal)
                        }
                    }
                }
            }
            .navigationTitle("")
            .onAppear {
                fetchMealsForSelectedCountry()
            }
            .onChange(of: selectedCountry) { _ in
                viewModel.list.removeAll()
                searchText = ""
                fetchMealsForSelectedCountry()
            }
        }
    }

    private func fetchMealsForSelectedCountry() {
        if let index = countries.firstIndex(of: selectedCountry) {
            viewModel.fetchData(meal_area: nationalities[index])
        }
    }

    private var filteredMeals: [MealDataIdentifiable] {
        if searchText.isEmpty {
            return viewModel.list
        } else {
            return viewModel.list.filter {
                $0.strMeal.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
