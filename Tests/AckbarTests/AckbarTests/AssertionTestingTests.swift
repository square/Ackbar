//
//  AssertionTests.swift
//  Ackbar Tests
//
//  Created by Brian Partridge on 7/6/15.
//  Copyright (c) 2015 Square, Inc. All rights reserved.
//

import AckbarTesting
@testable import AckbarAssertions
import XCTest


class AssertionTests: XCTestCase {
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        
        AckbarAssertions.testableAssertionsEnabled = true
    }
    
    /// MARK: - Tests
    
    func testAssert() {
        assertHitsDebugException(self.fireAssert())
    }
    
    func testAssertionFailure() {
        assertHitsDebugException(self.fireAssertionFailure())
    }
    
    func testPrecondition() {
        assertHitsDebugException(self.firePrecondition())
    }
    
    func testPreconditionFailure() {
        assertHitsDebugException(self.firePreconditionFailure())
    }
    
    func testFatalError() {
        assertHitsDebugException(self.fireFatalError())
    }
    
    func testOverridesSystemAssertions() {
        XCTAssertTrue(AckbarAssertions.overridesSystemAssertions())
        
        AckbarAssertions.testableAssertionsEnabled = false
        XCTAssertFalse(AckbarAssertions.overridesSystemAssertions())
    }
    
    /// MARK: - Private Methods
    
    private func fireAssert() {
        AckbarAssertions.assert(false)
        XCTFail("Execution should be halted before this code is run.")
    }

    private func fireAssertionFailure() {
        AckbarAssertions.assertionFailure()
        XCTFail("Execution should be halted before this code is run.")
    }
    
    private func firePrecondition() {
        AckbarAssertions.precondition(false)
        XCTFail("Execution should be halted before this code is run.")
    }
    
    private func firePreconditionFailure() {
        AckbarAssertions.preconditionFailure()
        // No need to test that execution doesn't make it past AckbarAssertions.preconditionFailure because it is @noreturn.
    }
    
    private func fireFatalError() {
        AckbarAssertions.fatalError()
        // No need to test that execution doesn't make it past AckbarAssertions.fatalError because it is @noreturn.
    }
}
