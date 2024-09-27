//
//  TheMealTests.swift
//  TheMealTests
//
//  Created by Leon Le Berre on 9/13/24.
//

import XCTest
import Alamofire
import OHHTTPStubs
import OHHTTPStubsSwift
@testable import TheMeal

final class TheMealTests: XCTestCase {
    var viewModel: MealListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = MealListViewModel()
        
        
        
        // Stub the network request
        
        stub(condition: isHost("www.themealdb.com")) { _ in
            let stubData = """
            {
                "meals": [
                    {
                        "strMeal": "Sushi",
                        "strMealThumb": "https://www.themealdb.com/images/media/meals/g046bb1560454026.jpg",
                        "idMeal": "53065"
                    },
                    {
                        "strMeal": "Tempura",
                        "strMealThumb": "https://www.themealdb.com/images/media/meals/1525873040.jpg",
                        "idMeal": "53060"
                    }
                ]
            }
            """.data(using: .utf8)!
            return HTTPStubsResponse(data: stubData, statusCode: 200, headers: nil)
        }
    }
    
    override func tearDown() {
        // Remove all stubs after test
        HTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    func testFetchDataSuccess() {
        // Arrange
        let expectation = XCTestExpectation(description: "Meals data fetched successfully")
        
        // Act
        viewModel.fetchData(meal_area: "Japanese")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Assert
            XCTAssertEqual(self.viewModel.list.count, 2, "The list should contain 2 meals")
            XCTAssertEqual(self.viewModel.list[0].strMeal, "Sushi", "First meal should be Sushi")
            XCTAssertEqual(self.viewModel.list[1].strMeal, "Tempura", "Second meal should be Tempura")
            XCTAssertEqual(self.viewModel.list[0].idMeal, "53065", "ID of the first meal should be 53065")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFetchDataFailure() {
        // Arrange
        HTTPStubs.removeAllStubs()  // Remove existing stubs to simulate a failure
        stub(condition: isHost("www.themealdb.com")) { _ in
            return HTTPStubsResponse(error: NSError(domain: NSURLErrorDomain, code: 500, userInfo: nil))
        }
        
        let expectation = XCTestExpectation(description: "Meal data fetch should fail")
        
        // Act
        viewModel.fetchData(meal_area: "Japanese")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Assert
            XCTAssertEqual(self.viewModel.list.count, 0, "The list should be empty due to the failure")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}
