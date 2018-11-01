import Foundation

public struct ExpandFilePath
{
    public typealias Func = (_ path: String) -> String

    private let expandVariables: ExpandVariablesInString.Func

    public init(expandVariables: @escaping ExpandVariablesInString.Func = ExpandVariablesInString().execute) {
        self.expandVariables = expandVariables
    }

    // MARK: -

    public func execute(path: String) -> String
    {
        var result = pathByReplacingTilde(path)
        result = pathByReplacingDot(result)
        result = expandVariables(result, ProcessInfo.processInfo.environment)
        return result
    }

    private func pathByReplacingDot(_ path: String) -> String
    {
        guard path.hasPrefix(".") else { return path }
        guard path.hasPrefix("./") || path.count == 1 else { return path }
        guard let range = path.range(of: "."), !range.isEmpty else { return path }
        return path.replacingCharacters(in: range, with: FileManager.default.currentDirectoryPath)
    }

    private func pathByReplacingTilde(_ path: String) -> String
    {
        guard path.hasPrefix("~") else { return path }
        guard path.hasPrefix("~/") || path.count == 1 else { return path }
        guard let range = path.range(of: "~"), !range.isEmpty else { return path }
        return path.replacingCharacters(in: range, with: "${HOME}")
    }
}
