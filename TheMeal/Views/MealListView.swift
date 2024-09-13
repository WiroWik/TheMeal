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
    
    var body: some View {
        Text("😋 MiamMiamTime 😋")
            .frame(alignment: .center)
        NavigationView {
            List(viewModel.list) { meal in
                NavigationLink(destination: DishView(dish_id: meal.idMeal, viewModel: DishViewModel())) {
                    HStack(alignment: .center) {
                        AsyncImage(url: URL(string: meal.strMealThumb)) { result in
                            result.image?
                                .resizable()
                                .scaledToFill()
                        }
                            .frame(width: 75, height: 75)
                        Text(meal.strMeal)
                    }
                }
            }
            .navigationTitle("")
            .onAppear {
                viewModel.fetchData(meal_area: "Japanese") // Replace with any meal_area you want
            }
        }
    }
}
