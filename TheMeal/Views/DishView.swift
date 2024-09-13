//
//  MealView.swift
//  TheMeal
//
//  Created by Thomas Brossard on 9/13/24.
//

import SwiftUI

struct DishView: View {
    @ObservedObject var viewModel: DishViewModel
    let dish_id: String
    
    init(dish_id: String, viewModel: DishViewModel) {
        self.dish_id = dish_id
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                if let dish = viewModel.dish_info {
                    VStack(alignment: .center) {
                        AsyncImage(url: URL(string: dish.strMealThumb)) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                            case .failure(_):
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFill()
                            case .empty:
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(width: 150, height: 150)
                        Text(dish.strMeal)
                            .bold()
                            .font(.largeTitle)
                        Text(dish.strArea)
                        Text("Instructtions").font(.title)
                        Text(dish.strInstructions)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
            .padding()
            .onAppear {
                viewModel.fetchData(dish_id: self.dish_id)
            }
        }
    }
}

