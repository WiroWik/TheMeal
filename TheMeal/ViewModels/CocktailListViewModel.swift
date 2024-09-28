//
//  CocktailListViewModel.swift
//  TheMeal
//
//  Created by Thomas Brossard on 9/27/24.
//

import Foundation
import SwiftUI
import Alamofire

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

// ViewModel for Cocktail List
class CocktailListViewModel: ObservableObject {
    @Published var list: [CocktailDataIdentifiable] = []

    init() {}

    func fetchData(cocktail_category: String) {
        let url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=\(cocktail_category)"
        AF.request(url)
            .validate()
            .responseDecodable(of: CocktailDataResponse.self) { response in
            switch response.result {
            case .success(let cocktailResponse):
                let cocktails = cocktailResponse.drinks
                var index: Int = 0
                for cocktail in cocktails {
                    self.list.append(CocktailDataIdentifiable(id: index, strDrink: cocktail.strDrink, strDrinkThumb: cocktail.strDrinkThumb, idDrink: cocktail.idDrink))
                    index += 1
                }

            case .failure(let error):
                print("Erreur : \(error)")
            }
        }
    }
}

