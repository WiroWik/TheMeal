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
                        // Dish Image
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
                        
                        // Dish Title
                        Text(dish.strMeal)
                            .bold()
                            .font(.largeTitle)
                        
                        Divider()
                        
                        // Dish Area and Category
                        Text("\(dish.strArea) - \(dish.strCategory)")
                            .foregroundColor(.orange)
                            .bold()
                        
                        // Dish Tags
                        if let tags = dish.strTags {
                            Text(tags)
                                .padding(.top, 5)
                        }
                        
                        Divider()
                        
                        // Ingredients and Measures Section
                        VStack(alignment: .leading) {
                            Text("Ingredients")
                                .font(.title3)
                                .bold()
                                .italic()
                                .underline()
                                .padding(.bottom, 5)
                            ForEach(0..<viewModel.ingredientList.count, id: \.self) { index in
                                if index < viewModel.measureList.count {
                                    Text("\(viewModel.ingredientList[index]) - \(viewModel.measureList[index])")
                                } else {
                                    Text(viewModel.ingredientList[index])
                                }
                            }
                        }
                        
                        Divider()
                        
                        // Instructions Section
                        VStack(alignment: .leading) {
                            Text("Instructions")
                                .font(.title3)
                                .bold()
                                .italic()
                                .underline()
                            Text(dish.strInstructions)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.top, 5)
                        }
                    }
                    .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    // Error Handling
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    // Loading Spinner
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
            .onAppear {
                viewModel.fetchData(dish_id: self.dish_id)
            }
        }
    }
}
