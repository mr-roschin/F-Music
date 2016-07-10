//
//  F_MusicTests.swift
//  F-MusicTests
//
//  Created by Alex on 05/07/16.
//  Copyright © 2016 Alexander Roschin. All rights reserved.
//


import XCTest

class F_MusicTests: XCTestCase {

    // MARK: F-Music Tests
    // Tests to confirm that the Track initializer returns when there's no name or a negative rating is provided.
    func testTrackInitialization() {
        // Success case.
        let potentialItem = Track(name: "New track", artist: "", photo: nil, rating: 5, about: "")
        XCTAssertNotNil(potentialItem)
        
        // Failure cases.
        let noName = Track(name: "", artist: "", photo: nil, rating: 0, about: "")
        XCTAssertNil(noName, "Empty name isn't valid")
        
        let badRating = Track(name: "Some name", artist: "", photo: nil, rating: -1, about: "")
        XCTAssertNil(badRating, "Negative ratings aren't valid")
    }
}
