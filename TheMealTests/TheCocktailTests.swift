//
//  TheCocktailTests.swift
//  TheMealTests
//
//  Created by Thomas Brossard on 9/28/24.
//

import XCTest
import Alamofire
import OHHTTPStubs
import OHHTTPStubsSwift
@testable import TheMeal

final class TheCocktailTests: XCTestCase {
    var viewModel: CocktailListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = CocktailListViewModel()
        
        
        
        // Stub the network request
        
        stub(condition: isHost("www.thecocktaildb.com")) { _ in
            let stubData = """
            {
                "drinks": [
                    {
                        "strDrink": "501 Blue",
                        "strDrinkThumb": "https://www.thecocktaildb.com/images/media/drink/ywxwqs1461867097.jpg",
                        "idDrink": "17105"
                    },
                    {
                        "strDrink": "50/50",
                        "strDrinkThumb": "https://www.thecocktaildb.com/images/media/drink/wwpyvr1461919316.jpg",
                        "idDrink": "14589"
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
        let expectation = XCTestExpectation(description: "Drinks data fetched successfully")
        
        // Act
        viewModel.fetchData(cocktail_category: "Ordinary_Drink")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Assert
            XCTAssertEqual(self.viewModel.list.count, 2, "The list should contain 2 drinks")
            XCTAssertEqual(self.viewModel.list[0].strDrink, "501 Blue", "First drink should be 501 Blue")
            XCTAssertEqual(self.viewModel.list[1].strDrink, "50/50", "Second drink should be 50/50")
            XCTAssertEqual(self.viewModel.list[0].idDrink, "17105", "ID of the first drink should be 17105")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFetchDataFailure() {
        // Arrange
        HTTPStubs.removeAllStubs()  // Remove existing stubs to simulate a failure
        stub(condition: isHost("www.thecocktaildb.com")) { _ in
            return HTTPStubsResponse(error: NSError(domain: NSURLErrorDomain, code: 500, userInfo: nil))
        }
        
        let expectation = XCTestExpectation(description: "Drink data fetch should fail")
        
        // Act
        viewModel.fetchData(cocktail_category: "Cocktail")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Assert
            XCTAssertEqual(self.viewModel.list.count, 0, "The list should be empty due to the failure")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}
