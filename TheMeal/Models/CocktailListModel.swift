//
//  CocktailListModel.swift
//  TheMeal
//
//  Created by Thomas Brossard on 9/28/24.
//

import Foundation
import SwiftUI

struct CocktailData: Decodable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}

struct CocktailDataResponse: Decodable {
    let drinks: [CocktailData]
}

struct CocktailDataIdentifiable: Identifiable {
    let id: Int

    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}
