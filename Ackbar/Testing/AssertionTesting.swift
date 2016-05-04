//
//  AssertionTests.swift
//  AckbarTesting
//
//  Created by Brian Partridge on 7/10/15.
//  Copyright (c) 2015 Square, Inc. All rights reserved.
//

import AckbarAssertions
import XCTest


/**
 * Triggers a test failure when expression does not trigger an assertion failure.
 * Internally, our assertions throw NSExceptions named AckbarAssertions.AssertionExceptionName.
 * @param expression An expression to evaluate.
 */
public func assertHitsDebugException(@autoclosure(escaping) expression: ()->(), _ message: String = "", file: StaticString = #file, line: UInt = #line) {
    guard let caughtException = ackbar_catchException(expression) else {
        XCTFail("Expression that was expected to fail did not fail. \(message)", file: file, line: line)
        return
    }
    guard caughtException.name == AckbarAssertions.AssertionExceptionName else {
        XCTFail("Expression triggered an unexpected \(caughtException.name) failure. \(message)", file: file, line: line)
        return
    }
    // Nothing to do, a valid exception was caught.
}
