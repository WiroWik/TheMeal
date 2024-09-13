//
//  MealListViewModel.swift
//  TheMeal
//
//  Created by Thomas Brossard on 9/13/24.
//

import Foundation
import SwiftUI
import Alamofire

struct MealData: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

struct MealDataResponse: Decodable {
    let meals: [MealData]
}

struct MealDataIdentifiable: Identifiable {
    let id: Int

    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

class MealListViewModel: ObservableObject {
    @Published var list: [MealDataIdentifiable] = []
    
    init() {}
    
    func fetchData(meal_area: String) {
            let url = "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(meal_area)"
            AF.request(url)
                .validate() // Pour valider les réponses HTTP 200..<300 et les erreurs de contenu
                .responseDecodable(of: MealDataResponse.self) { response in // Notez le type [User].self ici
                switch response.result {
                    case .success(let mealResponse):
                        let meals = mealResponse.meals
                        var index: Int = 0
                        for meal in meals {
                            self.list.append(MealDataIdentifiable(id: index, strMeal: meal.strMeal, strMealThumb: meal.strMealThumb, idMeal: meal.idMeal))
                            index += 1
                        }
                        
                    case .failure(let error):
                        print("Erreur : \(error)")
                }
            }
    }
}
