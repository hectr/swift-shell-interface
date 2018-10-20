// Copyright (c) 2017 Hèctor Marquès Ranea
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

public struct TaskContext
{
    public var environment: [String : String]?
    public var workingDirectory: String?

    public init(environment: [String : String]? = ProcessInfo.processInfo.environment,
                workingDirectory: String? = FileManager.default.currentDirectoryPath) {
        self.environment = environment
        self.workingDirectory = workingDirectory
    }
}

extension TaskContext: ExpressibleByStringLiteral
{
    public typealias UnicodeScalarLiteralType           = StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType)
    {
        self.environment = ProcessInfo.processInfo.environment
        self.workingDirectory = "\(value)"
    }
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType)
    {
        self.environment = ProcessInfo.processInfo.environment
        self.workingDirectory = value
    }
    
    public init(stringLiteral value: StringLiteralType)
    {
        self.environment = ProcessInfo.processInfo.environment
        self.workingDirectory = value
    }
}

extension TaskContext: ExpressibleByDictionaryLiteral
{
    public typealias Key   = String
    public typealias Value = String
    
    public init(dictionaryLiteral elements: (String, String)...)
    {
        var environment = [String : String]()
        for (key, value) in elements {
            environment[key] = value
        }
        self.environment = environment
        self.workingDirectory = FileManager.default.currentDirectoryPath

    }
}
