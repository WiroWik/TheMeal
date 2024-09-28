//
//  TheMealApp.swift
//  TheMeal
//
//  Created by Leon Le Berre on 9/13/24.
//

import SwiftUI

@main
struct TheMealApp: App {
    var body: some Scene {
        WindowGroup {
            CocktailListView(viewModel: CocktailListViewModel())
        }
    }
}
