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

public struct ReadPipe
{
    public typealias Func = (Pipe, _ removeTrailingNewLine: Bool) -> String
    
    public init() {}
    
    // MARK: -
    
    public func execute(pipe: Pipe, removeTrailingNewLine: Bool = true) -> String
    {
        let output = string(from: pipe)
        guard removeTrailingNewLine else { return output }
        return stringByRemoveTrailingNewLine(output)
    }
    
    private func string(from pipe: Pipe) -> String
    {
        let outData = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: outData, encoding: String.Encoding.utf8) ?? ""
    }
    
    private func stringByRemoveTrailingNewLine(_ string: String) -> String
    {
        guard string.hasSuffix("\n") else { return string }
        let lastIndex = string.index(before: string.endIndex)
        return String(string[string.startIndex ..< lastIndex])
    }
}
