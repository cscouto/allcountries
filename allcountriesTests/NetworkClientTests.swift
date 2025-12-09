//
//  NetworkClientTests.swift
//  allcountriesTests
//
//  Created by Tiago Do Couto on 12/9/25.
//

import XCTest
@testable import allcountries

final class NetworkClientTests: XCTestCase {
    
    func testInvalidURL() async {
        let client = NetworkClient()
        let url = URL(string: "invalid_url")!
        let request = URLRequest(url: url)
        
        let result: Result<Data, NetworkClient.NetworkError> = await client.request(request, type: Data.self)
        
        switch result {
        case .success:
            XCTFail("Request should not succeed")
        case .failure(let error):
            XCTAssertNotNil(error)
        }
    }
}

