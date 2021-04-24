//
//  BreakingBadAPI.swift
//  BBBrowser
//
//  Created by Andrew Rennard on 24/04/2021.
//

import Foundation

enum BreakingBadAPI: String {
    static let baseURL = URL(string:"https://breakingbadapi.com/api/")!

    case characters = "characters"
    
    var url: URL {
        return BreakingBadAPI.baseURL.appendingPathComponent(self.rawValue)
    }
}
