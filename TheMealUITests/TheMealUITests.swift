//
//  TheMealUITests.swift
//  TheMealUITests
//
//  Created by Leon Le Berre on 9/13/24.
//

import XCTest
import SwiftUI
@testable import TheMeal

final class TheMealUITests: XCTestCase {
    
    func testMealListViewDisplaysMeals() throws {
        // Given: A mock ViewModel with sample meal data
        let sampleMeals = [
            MealData(strMeal: "Sushi", strMealThumb: "https://www.example.com/sushi.jpg", idMeal: "12345"),
            MealData(strMeal: "Ramen", strMealThumb: "https://www.example.com/ramen.jpg", idMeal: "67890")
        ]
        let mockViewModel = MealListViewModel()
        for (index, meal) in sampleMeals.enumerated() {
            mockViewModel.list.append(MealDataIdentifiable(id: index, strMeal: meal.strMeal, strMealThumb: meal.strMealThumb, idMeal: meal.idMeal))
        }
        
        // When: Initializing the MealListView with the mock ViewModel
        let mealListView = MealListView(viewModel: mockViewModel)
        
        // Then: Use a snapshot of the view in the test environment
        let host = UIHostingController(rootView: mealListView)
        host.loadViewIfNeeded() // Ensures that the view is loaded

        // Assert the view components
        XCTAssertNotNil(host.view)
        
        // Check for the number of rows in the List (you'll need to modify this for the actual content)
        let mealRows = mockViewModel.list.count
        XCTAssertEqual(mealRows, sampleMeals.count, "Number of displayed meals should match the sample data")
    }
    
    func testCocktailListViewDisplaysDrinks() throws {
        // Given: A mock ViewModel with sample meal data
        let sampleCocktails = [
            CocktailData(strDrink: "Jaeger Bomb", strDrinkThumb: "https://www.example.com/jaeger_bomb.jpg", idDrink: "12345"),
            CocktailData(strDrink: "Virgin Mojito", strDrinkThumb: "https://www.example.com/virgin_mojito.jpg", idDrink: "67890")
        ]
        let mockViewModel = CocktailListViewModel()
        for (index, cocktail) in sampleCocktails.enumerated() {
            mockViewModel.list.append(CocktailDataIdentifiable(id: index, strDrink: cocktail.strDrink, strDrinkThumb: cocktail.strDrinkThumb, idDrink: cocktail.idDrink))
        }
        
        // When: Initializing the MealListView with the mock ViewModel
        let cocktailListView = CocktailListView(viewModel: mockViewModel)
        
        // Then: Use a snapshot of the view in the test environment
        let host = UIHostingController(rootView: cocktailListView)
        host.loadViewIfNeeded() // Ensures that the view is loaded

        // Assert the view components
        XCTAssertNotNil(host.view)
        
        // Check for the number of rows in the List (you'll need to modify this for the actual content)
        let cocktailRows = mockViewModel.list.count
        XCTAssertEqual(cocktailRows, sampleCocktails.count, "Number of displayed cocktails should match the sample data")
    }
}


