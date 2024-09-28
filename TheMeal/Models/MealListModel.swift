//
//  MealListModel.swift
//  TheMeal
//
//  Created by Thomas Brossard on 9/13/24.
//

import Foundation
import SwiftUI

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
