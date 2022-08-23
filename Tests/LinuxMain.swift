import XCTest

import ak_debugTests

var tests = [XCTestCaseEntry]()
tests += ak_debugTests.allTests()
XCTMain(tests)
