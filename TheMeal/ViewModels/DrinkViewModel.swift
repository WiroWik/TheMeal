//
//  DrinkViewModel.swift
//  TheMeal
//
//  Created by Thomas Brossard on 9/27/24.
//

import Foundation
import SwiftUI
import SwiftyJSON
import Alamofire

class DrinkViewModel: ObservableObject {
    @Published var drink_info: DrinkData?
    @Published var errorMessage: String?

    func fetchData(drink_id: String) {
        let url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(drink_id)"

        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    
                    if let drinks = json["drinks"].array, let firstDrink = drinks.first {
                        let drink = self.parseDrink(from: firstDrink)
                        self.drink_info = drink
                        self.errorMessage = nil
                    } else {
                        self.errorMessage = "No drink found"
                    }
                    
                case .failure(let error):
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
            }
    }
    
    private func parseDrink(from json: JSON) -> DrinkData {
        var tempIngredientsList: [String] = []
        var tempMeasuresList: [String] = []
        
        // Loop through ingredients and measures
        for i in 1...15 {
            let ingredient = json["strIngredient\(i)"].stringValue
            let measure = json["strMeasure\(i)"].stringValue
            
            // Only add non-empty ingredients and measures
            if !ingredient.isEmpty {
                tempIngredientsList.append(ingredient)
            }
            
            if !measure.isEmpty {
                tempMeasuresList.append(measure)
            }
        }
        
        return DrinkData(
            idDrink: json["idDrink"].stringValue,
            strDrink: json["strDrink"].stringValue,
            strTags: json["strTags"].string,
            strCategory: json["strCategory"].stringValue,
            strAlcoholic: json["strAlcoholic"].stringValue,
            strGlass: json["strGlass"].stringValue,
            strInstructions: json["strInstructions"].stringValue,
            strDrinkThumb: json["strDrinkThumb"].stringValue,
            ingredientsList: tempIngredientsList,
            measuresList: tempMeasuresList
        )
    }

}

