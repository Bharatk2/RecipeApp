//
//  RecipeAppTests.swift
//  RecipeAppTests
//
//  Created by Admin on 7/2/24.
//

import XCTest

final class RecipeAppTests: XCTestCase {
    let timeout: TimeInterval = 5
    
    override func setUpWithError() throws {
        MockURLProtocol.requestHandler = nil
        // using ephemeral configuration to implement testing in order to avoid storing data to disk.
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
    }

    override func tearDownWithError() throws {
        MockURLProtocol.requestHandler = nil
    }

}
