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

public struct LaunchTask
{
    public typealias Func = (_ launchPath: String, _ arguments: [String], _ context: TaskContext?, _ waitUntilExit: Bool) -> TaskResult
    
    private let buildProcess: BuildProcess.Func
    private let readPipe:     ReadPipe.Func
    
    public init(buildProcess: @escaping BuildProcess.Func = BuildProcess().execute,
                readPipe:     @escaping ReadPipe.Func     = ReadPipe().execute)
    {
        self.buildProcess = buildProcess
        self.readPipe     = readPipe
    }
    
    // MARK: -
    
    public func execute(launchPath: String, arguments: [String] = [], context: TaskContext? = nil, waitUntilExit: Bool = true) -> TaskResult
    {
        let stdOut = Pipe()
        let stdErr = Pipe()
        let task = buildProcess(launchPath, arguments, context, stdOut, stdErr)
        return launch(task, stdOut: stdOut, stdErr: stdErr, waitUntilExit: waitUntilExit)
    }
    
    private func launch(_ task: Process, stdOut: Pipe, stdErr: Pipe, waitUntilExit: Bool) -> TaskResult
    {
        task.launch()
        if waitUntilExit {
            task.waitUntilExit()
        }
        let output = readPipe(stdOut, true)
        let error = readPipe(stdErr, true)
        let status: Int?
        let uncaughtSignal: Bool
        if task.isRunning {
            status = nil
            uncaughtSignal = false
        } else {
            status = Int(task.terminationStatus)
            switch task.terminationReason {
            case .exit:
                uncaughtSignal = true
            case .uncaughtSignal:
                uncaughtSignal = false
            }
        }
        return TaskResult(
            standardOutput: output,
            standardError: error,
            terminationStatus: status,
            terminatedDueUncaughtSignal: uncaughtSignal
        )
    }
}
