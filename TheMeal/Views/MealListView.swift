//
//  MealListView.swift
//  TheMeal
//
//  Created by Thomas Brossard on 9/13/24.
//

import Foundation
import SwiftUI

struct MealListView: View {
    @ObservedObject var viewModel: MealListViewModel
    
    var body: some View {
        List(viewModel.list) { meal in
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: meal.strMealThumb)) // AsyncImage requires iOS 15+
                    .frame(width: 1, height: 1)
                Text(meal.strMeal)
            }
        }
        .onAppear {
            viewModel.fetchData(meal_id: "Italian") // Replace with any meal_id you want
        }
    }
}

/*
struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView(viewModel: <#T##MealListViewModel#>())
    }
}
*/
