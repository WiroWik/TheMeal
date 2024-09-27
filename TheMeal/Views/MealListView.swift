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
        "Canada", "China", "Croatia", "Egypt", "France", "Greece",
        "India", "Ireland", "Italy", "Jamaica", "Japan", "Malaysia",
        "Mexico", "Morocco", "Netherlands", "Philippines", "Poland",
        "Portugal", "Russia", "Saint Kitts and Nevis", "Slovakia",
        "Spain", "Thailand", "Tunisia", "Turkey", "Ukraine",
        "United Kingdom", "United States", "Vietnam"
    ]
    
    // List of nationalities
    let nationalities = [
        "Canadian", "Chinese", "Croatian", "Egyptian", "French", "Greek",
        "Indian", "Irish", "Italian", "Jamaican", "Japanese", "Malaysian",
        "Mexican", "Moroccan", "Dutch", "Filipino", "Polish",
        "Portuguese", "Russian", "Saint Kitts and Nevis", "Slovak",
        "Spanish", "Thai", "Tunisian", "Turkish", "Ukrainian",
        "British", "American", "Vietnamese"
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text("😋 MealTime 😋")
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
                .pickerStyle(MenuPickerStyle())
                .frame(height: 50)
                
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
                viewModel.list.removeAll()
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
