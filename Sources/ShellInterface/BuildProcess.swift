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

public struct BuildProcess
{
    public typealias Func = (_ launchPath: String, _ arguments: [String], _ context: TaskContext?, _ stdOut: Pipe?, _ stdErr: Pipe?) -> Process
    
    // MARK: -
    
    public func execute(launchPath: String, arguments: [String] = [], context: TaskContext? = nil, stdOut: Pipe? = nil, stdErr: Pipe? = nil) -> Process
    {
        let task = Process()
        task.launchPath = launchPath
        task.arguments = arguments
        if let environment = context?.environment {
            task.environment = environment
        }
        if let workingDirectory = context?.workingDirectory {
            task.currentDirectoryPath = workingDirectory
        }
        if let stdOut = stdOut {
            task.standardOutput = stdOut
        }
        if let stdErr = stdErr {
            task.standardError = stdErr
        }
        return task
    }
}
