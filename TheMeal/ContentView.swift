//
//  ContentView.swift
//  TheMeal
//
//  Created by Leon Le Berre on 9/13/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            Text("😋 Miam Time Glou🍸").tag(0)
            TabView(selection: $selectedTab) {
                MealListView(viewModel: MealListViewModel())
                    .tabItem {
                        Label("Meals", systemImage: "fork.knife")
                    }
                    .tag(1)
                
                CocktailListView(viewModel: CocktailListViewModel())
                    .tabItem {
                        Label("Cocktails", systemImage: "wineglass")
                    }
                    .tag(2)
            }
        }
    }
}
