//
//  ContentView.swift
//  TheMeal
//
//  Created by Leon Le Berre on 9/13/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MealListView(viewModel: MealListViewModel())
                .tabItem {
                    Label("Meals", systemImage: "fork.knife")
                }
            
            CocktailListView(viewModel: CocktailListViewModel())
                .tabItem {
                    Label("Cocktails", systemImage: "wineglass")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView(viewModel: MealListViewModel())
    }
}
