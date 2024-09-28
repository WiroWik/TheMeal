//
//  MealListViewModel.swift
//  TheMeal
//
//  Created by Thomas Brossard on 9/13/24.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class MealListViewModel: ObservableObject {
    @Published var list: [MealDataIdentifiable] = []
    @Published var listArea: [String] = []
    
    
    init() {}
    
    func fetchData(meal_area: String) {
        let url = "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(meal_area)"

        AF.request(url)
            .validate()
            .responseDecodable(of: MealDataResponse.self) { response in
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
    
    func fetchAreas() {
        let url = "https://www.themealdb.com/api/json/v1/1/list.php?a=list"

        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    
                    if let areas = json["meals"].array, let firstArea = areas.first {
                        self.listArea.append(firstArea["strArea"].stringValue)
                    }
                    
                case .failure(let error):
                    print("Erreur : \(error)")
                    
                }
            }
        
    }
}
