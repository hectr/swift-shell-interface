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

public struct ExecuteCommand
{
    public typealias Func = (_ command: String, _ arguments: [String], _ context: TaskContext?, _ waitUntilExit: Bool) -> TaskResult
    
    private let pathToShell: String
    private let params:      [String]
    private let launchTask:  LaunchTask.Func
    
    public init(pathToShell: String                    = "/bin/sh",
                params:      [String]                  = ["-l", "-c"],
                launchTask:  @escaping LaunchTask.Func = LaunchTask().execute)
    {
        self.pathToShell = pathToShell
        self.params      = params
        self.launchTask  = launchTask
    }
    
    // MARK: -
    
    public func execute(command: String, arguments: [String] = [], context: TaskContext? = nil, waitUntilExit: Bool = true) -> TaskResult
    {
        // http://stackoverflow.com/a/31510860/870560
        var params = self.params
        params.append("which \(command)")
        let which = launchTask(pathToShell, params, context, waitUntilExit)
        let pathForCommand = which.standardOutput.trimmingCharacters(in: .whitespacesAndNewlines)
        return launchTask(pathForCommand, arguments, context, waitUntilExit)
    }
}
