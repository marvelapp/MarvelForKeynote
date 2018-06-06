//  Copyright (c) 2015 Majesty Software.
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
//

import Foundation

public func runScript(_ script: String) {
    Process.launchedProcess(launchPath: "/usr/bin/osascript", arguments: ["-e", script])
}

public func notifyUserWithMessage(_ message: String, title: String) {
    let script = "display notification \"\(message)\" with title \"\(title)\""
    runScript(script)
}

public func commandOutput(_ commandPath: String, withArguments arguments: [String]? = nil, currentDirectoryPath: String? = nil) -> String? {
    let process = Process()
    let pipe = Pipe()
    process.standardOutput = pipe.fileHandleForWriting
    process.launchPath = commandPath
    if currentDirectoryPath != nil {
        process.currentDirectoryPath = currentDirectoryPath!
    }
    if arguments != nil {
        process.arguments = arguments!
    }
    process.launch()
    process.waitUntilExit()
    pipe.fileHandleForWriting.closeFile()
    return NSString(data: pipe.fileHandleForReading.availableData, encoding: String.Encoding.utf8.rawValue) as String?
}
