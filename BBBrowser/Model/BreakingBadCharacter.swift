//
//  BreakingBadCharacter.swift
//  BBBrowser
//
//  Created by AndyRennard on 23/04/2021.
//

import Foundation

struct BreakingBadCharacter: Codable, Identifiable {
    let id: Int
    let name: String
    let birthday: String
    let occupation: [String]
    let imageURL: URL
    let status: String
    let nickname: String
    let episodeAppearances: [Int]
    let actorName: String
    let category: String
    let betterCallSaulAppearances: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case name
        case birthday
        case occupation
        case imageURL = "img"
        case status
        case nickname
        case episodeAppearances = "appearance"
        case actorName = "portrayed"
        case category
        case betterCallSaulAppearances = "better_call_saul_appearance"
    }
}
