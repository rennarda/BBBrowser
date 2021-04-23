//
//  APIResponseTests.swift
//  BBBrowserTests
//
//  Created by AndyRennard on 23/04/2021.
//

import XCTest
@testable import BBBrowser

class APIResponseTests: XCTestCase {
    
    var fixtureData: Data!
    
    override func setUpWithError() throws {
        let fixtureURL = Bundle(for: Self.self).url(forResource: "apiresponse", withExtension: "json")!
        fixtureData = try! Data.init(contentsOf: fixtureURL)
    }

    override func tearDownWithError() throws {

    }

    func test_canParseResponseJSON() throws {
        do {
            let characters = try JSONDecoder().decode([BreakingBadCharacter].self, from: fixtureData)
            XCTAssertNotNil(characters)
            let walt = characters.first!
            XCTAssertEqual(walt.id, 1)
            XCTAssertEqual(walt.birthday, "09-07-1958")
            XCTAssertEqual(walt.name, "Walter White")
            XCTAssertEqual(walt.occupation, ["High School Chemistry Teacher","Meth King Pin"] )
            XCTAssertEqual(walt.imageURL.absoluteString, "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")
            XCTAssertEqual(walt.status, "Presumed dead" )
            XCTAssertEqual(walt.nickname, "Heisenberg")
            XCTAssertEqual(walt.episodeAppearances, [1,2,3,4,5])
            XCTAssertEqual(walt.actorName, "Bryan Cranston")
            XCTAssertEqual(walt.category, "Breaking Bad")
            XCTAssertEqual(walt.betterCallSaulAppearances.count, 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }


}
