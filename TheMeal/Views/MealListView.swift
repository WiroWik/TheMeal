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
    @State private var selectedCountry: String = "Canada"

    // List of countries
    let countries = [
        "Algérie",
        "Argentine",
        "Arabie saoudite",
        "Canada",
        "Chine",
        "Croatie",
        "Egypte",
        "Espagne",
        "France",
        "Grece",
        "Irlande",
        "Inde",
        "Italie",
        "Jamaïque",
        "Japon",
        "Malaisie",
        "Maroc",
        "Mexique",
        "Norvège",
        "Pays bas",
        "Philippines",
        "Pologne",
        "Portugal",
        "Russie",
        "Saint-Christophe-et-Niévès",
        "Slovénie",
        "Syrie",
        "Thailande",
        "Tunisie",
        "Ukraine",
        "États Unis",
        "Royaume Uni"
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
                viewModel.fetchData(meal_area: "Canadian"/* selectedCountry */) // Replace with any meal_area you want
            }
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
