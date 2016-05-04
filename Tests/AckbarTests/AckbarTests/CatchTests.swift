//
//  CatchTests.swift
//  Ackbar Tests
//
//  Created by Brian Partridge on 2/7/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import AckbarTesting
import XCTest


class CatchTests: XCTestCase {

    func testCatchException_returnsNilWhenNothingThrows() {
        let caughtException = ackbar_catchException() {}
        XCTAssertNil(caughtException)
    }
    
    func testCatchException_returnsCaughtExceptions() {
        let expectedException = NSException(name: "Test", reason: "testing", userInfo: nil)
        let caughtException = ackbar_catchException() {
            expectedException.raise()
        }
        XCTAssertEqual(expectedException, caughtException)
    }    
}
