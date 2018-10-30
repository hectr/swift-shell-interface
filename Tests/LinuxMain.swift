import XCTest
@testable import ShellInterfaceTests

XCTMain([
    testCase(BuildProcessTests.allTests),
    testCase(ExecuteCommandTests.allTests),
    testCase(LaunchTaskTests.allTests),
    testCase(ReadPipeTests.allTests),
    testCase(TaskContextTests.allTests),
    testCase(TaskFailureTests.allTests),
    testCase(TaskResultTests.allTests),
    testCase(ExpandVariablesInStringTests.allTests),
])
