//
//  DrinkView.swift
//  TheMeal
//
//  Created by Thomas Brossard on 9/27/24.
//

import Foundation
import SwiftUI

struct DrinkView: View {
    @ObservableObject var viewModel: DrinkViewModel
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
                        }
                    }
                }
            }
        }
    }
}
