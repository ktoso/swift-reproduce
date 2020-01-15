import XCTest

import swift_reproduceTests

var tests = [XCTestCaseEntry]()
tests += swift_reproduceTests.allTests()
XCTMain(tests)
