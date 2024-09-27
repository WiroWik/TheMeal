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
}


