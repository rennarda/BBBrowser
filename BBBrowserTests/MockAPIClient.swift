//
//  MockAPIClient.swift
//  BBBrowserTests
//
//  Created by Andrew Rennard on 24/04/2021.
//

import Foundation
import Combine
@testable import BBBrowser

class MockAPIClient: APIClientProtocol {
    let fixtureName: String
    let error: APIError?
    
    init(fixtureName: String, error: APIError? = nil) {
        self.fixtureName = fixtureName
        self.error = error
    }
    
    func get<T>(_ url: URL) -> AnyPublisher<T, Error> where T : Decodable {
        
        Just(loadFixture())
            .tryMap({ data in
                let decoder = JSONDecoder()
                if let error = self.error {
                    throw error
                }
                return try decoder.decode(T.self, from: data)
            })
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func loadFixture() -> Data {
        let fixtureURL = Bundle(for: Self.self).url(forResource: fixtureName, withExtension: "json")!
        return try! Data.init(contentsOf: fixtureURL)
    }
}
