# Ackbar

## Description

Swift's type system ensures that your methods are interacting with objects of the correct type, but you are left to using conditionals and assertions to validate their values.

You can test conditionals, but until now you were not able to test Swift's assertions (`assert`, `precondition`, `fatalError`) without crashing your test run.  `Ackbar` allows you to write unit tests which verify that your assertions have test coverage and fire when you expect them to.

This is performed in 2 parts:

- Add `AckbarAssertions` to your app/framework target. It will add methods to override Swift's assertions in `DEBUG` builds.
- Add `AckbarTesting` to your test target and use `assertHitsDebugException` to test that your assertions are enforced. 

For more details see [the detailed design](#design) below.

## Installation

In your app/framework's Podfile:

        pod 'AckbarAssertions'


In your test target's Podfile:

        pod 'AckbarTesting'

        
Install the pods:

        pod install
        
**IMPORTANT**: Open `Ackbar/Assertions/README.swift` and follow the instructions to manually integrate the traps into your app target. For more details see [the design section](#distributionmethod).

## Usage

In your app/framework:

        func foo(someConditionThatMustBeTrueToSucceed: Bool) {
            precondition(someConditionThatMustBeTrueToSucceed)     // Write your assertions as you normally would.
            ...
        }

In your tests:

        func testFoo() {
            assertHitsDebugException(foo(false))                  // Use like you would use XCTAssert*.
        }

Take a look at [Endor](Example/Endor) for a larger example of how to use `AckbarTesting` in your tests.

## Design
Testing assertions works by throwing `NSException`s for assertion failures and using Objective-C's `try`/`catch` exception handling functionality to detect and trigger test failures.

### Rationale
Assertion failures typically terminate a process, but this drastically reduces testability.  To make assertions testable, we need something that can be detected, and also unwinds the stack so other tests can continue to run after detection.  At this time, the best option for this is to use exceptions.

### Alternative Designs
Attaching a 'handler' to each thread a la `NSAssertionHandler` is a non-starter because this can effectively only be used for logging the failure. It does not facilitate unwinding the stack.

Swift's error handling by throwing errors is not an option because it doesn't unwind the stack and requires all callers to use the `try` keyword.  This could interferre with legitimate uses of Swift's error handling style.

The family of Swift assertions send trap signals when an assertion fails. We could implement a signal handler, but given the hairiness of dropping down to mach, combined with the churn that the Swift language is going through, we chose not to go this route at this time. There are [examples](http://www.cocoawithlove.com/blog/2016/02/02/partial-functions-part-two-catching-precondition-failures.html) of using a signal handler for this already though.

### Distribution Method
We use CocoaPods for distribution because it makes getting the code into your project easy.  However, in order for the testable assertions in AckbarAssertions to override Swift's assterions you must add `AckbarAssertions.swift` to the app and framework targets that you want to test.  Otherwise you would need to update your code to call `AckbarAssertions.assert` rather than just `assert`.

If you choose to make explicit calls to `AckbarAssertions.assert` be aware that your crash reports may be affected. Many crash reporters rollup 'related' crashes bashed upon stack trace similarities, so 2 different crashes with `AckbarAssertions.assert` at the top of the stack trace will result in different crashes being rolled up into different instances of the same crash.

## License
[Apache License, Version 2.0](LICENSE)

## Contributing

We’re glad you’re interested in **Ackbar**, and we’d love to see where you take it. Please read our [contributing guidelines](Contributing.md) prior to submitting a Pull Request.

Thanks!