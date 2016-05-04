//
//  Assertions.swift
//  AckbarAssertions
//
//  Created by Brian Partridge on 2/7/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import AckbarAssertions
import Foundation


/**
 * Only compile these assertion replacements into DEBUG or COCOAPODS builds.
 *
 * When compiling into your app, we only want these assertions to override the 
 * system assertions in DEBUG builds. Some crash reporters get confused when the
 * top entry in the stack is shared across multiple crashes which ends up 
 * rolling up otherwise unrelated issues into a single issue.
 *
 * When compiling into a CocoaPod framework, these assertions can be built right
 * into the framework because they will be namespaced and not override the 
 * system assertions.
 */
#if DEBUG || COCOAPODS
    
// MARK: - Public Properties
    
/**
 * Kill switch to disable testable assertions in some environments. Ex: Enable 
 * for unit tests, but disable for KIF tests.
 */
public var testableAssertionsEnabled: Bool = true
    
// MARK: - Public Functions

/**
 * Testable replacement for assert().
 *
 * @param condition A block returning false if a particular condition was not met.
 * @param message A block returning a message to be logged if the condition was not met.
 * @param file The filename from which the method was called.
 * @param line The line number in file from which the method was called.
 */
public func assert(@autoclosure condition: () -> Bool, @autoclosure _ message: () -> String = "", file: StaticString = #file, line: UInt = #line) {
    if overridesSystemAssertions() {
        evaluateAssertion(condition, message: message, file: file, line: line, failurePrompt: "assertion failed")
    } else {
        Swift.assert(condition(), message(), file: file, line: line)
    }
}

/**
 * Testable replacement for assertionFailure().
 *
 * @param message A block returning a message to be logged.
 * @param file The filename from which the method was called.
 * @param line The line number in file from which the method was called.
 */
public func assertionFailure(@autoclosure message: () -> String = "", file: StaticString = #file, line: UInt = #line) {
    if overridesSystemAssertions() {
        evaluateAssertion(false, message: message, file: file, line: line, failurePrompt: "assertion failed")
    } else {
        Swift.assertionFailure(message(), file: file, line: line)
    }
}


/**
 * Testable replacement for precondition().
 *
 * @param condition A block returning false if a particular condition was not met.
 * @param message A block returning a message to be logged if the condition was not met.
 * @param file The filename from which the method was called.
 * @param line The line number in file from which the method was called.
 */
public func precondition(@autoclosure condition: () -> Bool, @autoclosure _ message: () -> String = "", file: StaticString = #file, line: UInt = #line) {
    if overridesSystemAssertions() {
        evaluateAssertion(condition, message: message, file: file, line: line, failurePrompt: "precondition failed")
    } else {
        Swift.precondition(condition(), message(), file: file, line: line)
    }
}
    
/**
 * Testable replacement for preconditionFailure().
 *
 * @param message A block returning a message to be logged.
 * @param file The filename from which the method was called.
 * @param line The line number in file from which the method was called.
 */
@noreturn public func preconditionFailure(@autoclosure message: () -> String = "", file: StaticString = #file, line: UInt = #line) {
    if overridesSystemAssertions() {
        evaluateAssertion(false, message: message, file: file, line: line, failurePrompt: "precondition failed")
    } else {
        Swift.preconditionFailure(message(), file: file, line: line)
    }
    
    // Never called, only here so this method can be marked @noreturn
    abort()
}

/**
 * Testable replacement for fatalError().
 *
 * @param message A block returning a message to be logged.
 * @param file The filename from which the method was called.
 * @param line The line number in file from which the method was called.
 */
@noreturn public func fatalError(@autoclosure message: () -> String = "", file: StaticString = #file, line: UInt = #line) {
    if overridesSystemAssertions() {
        evaluateAssertion(false, message: message, file: file, line: line, failurePrompt: "fatal error")
    } else {
        Swift.fatalError(message(), file: file, line: line)
    }
    
    // Never called, only here so this method can be marked @noreturn
    abort()
}

// MARK: - Internal Functions

/// Returns true for test environments where testable assertions are enabled
internal func overridesSystemAssertions() -> Bool {
    return (NSClassFromString("XCTestCase") != nil) && testableAssertionsEnabled
}

/// MARK: - Private Functions

/**
* Evaluates the condition block, throwing an exception if the result is false.
*
* @param condition A block returning false if a particular condition was not met.
* @param message A block returning a message to be logged if the condition was not met.
* @param file The filename from which the condition was defined.
* @param line The line number in file from which the condition was defined.
* @param prompt A prefix to be inserted before the message to identify the failure type.
*/
private func evaluateAssertion(@autoclosure condition: () -> Bool, @autoclosure message: () -> String, file: StaticString, line: UInt, failurePrompt: String) {
    guard !condition() else { return }

    let failureMessage = message()
    NSLog(formatAssertionFailureMessageForLogging(failurePrompt, message: failureMessage, file: file, line: line))
    NSException(name: AckbarAssertions.AssertionExceptionName, reason: failureMessage, userInfo: nil).raise()
}

/// Formats a failure message for display in console logs in the same format as system assertions. 
/// The result should not be passed into system assertions to avoid redundant data.
private func formatAssertionFailureMessageForLogging(prompt: String, message: String, file: StaticString, line: UInt) -> String {
    return "\(prompt): \(message): file \(file), line \(line)"
}

#endif // DEBUG || COCOAPODS
