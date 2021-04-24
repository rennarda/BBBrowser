//
//  APIClient.swift
//  BBBrowser
//
//  Created by Andrew Rennard on 24/04/2021.
//

import Foundation
import Combine

struct APIError: Decodable, Error {
    let statusCode: Int
}

protocol APIClientProtocol {
    func get<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error>
}

struct APIClient: APIClientProtocol {
    
    public func get<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
        .tryMap({ result in
            let decoder = JSONDecoder()
            guard let urlResponse = result.response as? HTTPURLResponse,
                  (200...299).contains(urlResponse.statusCode)
            else {
                let apiError = try decoder.decode(APIError.self, from: result.data)
                throw apiError
            }
            return try decoder.decode(T.self, from: result.data)
        })
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
