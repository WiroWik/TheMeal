//
//  DrinkView.swift
//  TheMeal
//
//  Created by Thomas Brossard on 9/27/24.
//

import SwiftUI

struct DrinkView: View {
    @ObservedObject var viewModel: DrinkViewModel
    let drink_id: String

    init(drink_id: String, viewModel: DrinkViewModel) {
        self.drink_id = drink_id
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            ScrollView {
                if let drink = viewModel.drink_info {
                    VStack(alignment: .center) {
                        AsyncImage(url: URL(string: drink.strDrinkThumb)) { phase in
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
                        
                        // Drink Title
                        Text(drink.strDrink)
                            .bold()
                            .font(.largeTitle)
                        
                        Divider()
                        
                        // Drink Category
                        Text("\(drink.strCategory)")
                            .foregroundColor(.orange)
                            .bold()
                        
                        // Drink Tags
                        if let tags = drink.strTags {
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
                            ForEach(0..<drink.ingredientsList.count, id: \.self) { index in
                                if index < drink.measuresList.count {
                                    Text("\(drink.ingredientsList[index]) - \(drink.measuresList[index])")
                                } else {
                                    Text(drink.ingredientsList[index])
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
                            Text(drink.strInstructions)
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
                viewModel.fetchData(drink_id: self.drink_id)
            }
        }
    }
}
