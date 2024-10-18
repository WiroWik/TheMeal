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
        let app = XCUIApplication()
        app.launch()

        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Beef Bourguignon"]/*[[".cells.buttons[\"Beef Bourguignon\"]",".buttons[\"Beef Bourguignon\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars.buttons["Back"].tap()

        app.textFields["Search for a meal..."].tap()
        app.textFields["Search for a meal..."].typeText("Chicken")
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Chicken Marengo"]/*[[".cells.buttons[\"Chicken Marengo\"]",".buttons[\"Chicken Marengo\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars.buttons["Back"].tap()
        app.buttons["X Circle"].tap()
        
        
    }
    
    func testCocktailListViewDisplaysDrinks() throws {
        let app = XCUIApplication()
        app.launch()

        app.tabBars.buttons["Cocktails"].tap()
        app.collectionViews.buttons["747 Drink"].tap()
        app.navigationBars.buttons["Back"].tap()

        app.textFields["Search for a cocktail..."].tap()
        app.textFields["Search for a cocktail..."].typeText("Bee")
        app.collectionViews.buttons["Honey Bee"].tap()
        app.navigationBars.buttons["Back"].tap()
        app.buttons["X Circle"].tap()
    }
}


