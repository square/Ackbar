//
//  EndorTests.swift
//  EndorTests
//
//  Created by Brian Partridge on 5/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

@testable import Endor
import AckbarTesting
import XCTest

class EndorTests: XCTestCase {
    
    let deathStarAssult = DeathStarAssault()
    
    func test_beginDeathStarAssault_withoutPlansFails() {
        deathStarAssult.hasDeathStarPlans = false
        assertHitsDebugException(self.deathStarAssult.run(), "You need a plan of attack.")
        XCTAssertFalse(deathStarAssult.complete)
    }
    
    func test_beginDeathStarAssault_whenTheEmpireIsAwareFails() {
        deathStarAssult.isTheEmpireAware = true
        assertHitsDebugException(self.deathStarAssult.run(), "It's not a sneak attack.")
        XCTAssertFalse(deathStarAssult.complete)
    }
    
    func test_beginDeathStarAssault_whenPreconditionsAreMet() {
        deathStarAssult.run()
        XCTAssertTrue(deathStarAssult.complete)
    }
    
}
