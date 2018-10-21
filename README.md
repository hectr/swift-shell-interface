# ShellInterface

[![Version](https://img.shields.io/cocoapods/v/ShellInterface.svg?style=flat)](http://cocoapods.org/pods/ShellInterface)
[![License](https://img.shields.io/cocoapods/l/ShellInterface.svg?style=flat)](http://cocoapods.org/pods/ShellInterface)
[![Platform](https://img.shields.io/cocoapods/p/ShellInterface.svg?style=flat)](http://cocoapods.org/pods/ShellInterface)

A shell interface built as a thin abstraction layer over Foundation's `Process`.

## Usage

```swift
// -- Simple use case example:

let shell = ExecuteCommand()
let result = shell.execute(command: "cat",
arguments: ["/tmp/log.0.txt", "/tmp/log.1.txt"],
waitUntilExit: true)

// -- Customization example:

var context = TaskContext()
context.environment = ["HOME": "/Users/me"]
context.workingDirectory = "/tmp/"

let bash = ExecuteCommand(pathToShell: "/bin/bash")
_ = bash.execute(command: "curl", arguments: ["http://example.org"], context: context, waitUntilExit:false)

// -- Error reporting examples:

print(result.standardError)

guard let terminationStatus = result.terminationStatus else {
    throw TaskFailure.stillRunning(domain: #function, code: #line)
}

guard terminationStatus == 0 else {
    throw TaskFailure.nonzeroTerminationStatus(
        domain: #function,
        code: #line,
        terminationStatus: terminationStatus,
        uncaughtSignal: result.terminatedDueUncaughtSignal
    )
}

guard !result.standardOutput.isEmpty else {
    throw TaskFailure.emptyOutput(domain: #function, code: #line)
}
```  

## Installation

ShellInterface is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ShellInterface"
```

## License

ShellInterface is available under the MIT license. See the LICENSE file for more info.

## Alternatives

- <https://github.com/MoralAlberto/SwiftShell>
