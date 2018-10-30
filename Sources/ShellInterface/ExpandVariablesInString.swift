import Foundation

public struct ExpandVariablesInString
{
    public typealias Func = (_ string: String, _ variables: [String: String]) -> String

    public init() {}

    // MARK: -

    public func execute(string: String, variables: [String: String] = ProcessInfo.processInfo.environment) -> String
    {
        var result = string
        for (key, value) in variables {
            result = result.replacingOccurrences(of: "${\(key)}", with: value)
            if let range: Range<String.Index> = result.range(of: "$\(key)"), canSubstituteSimplifiedVariableAtRange(range, in: result) {
                result = result.replacingCharacters(in: range, with: value)
            }
        }
        return result
    }

    private func canSubstituteSimplifiedVariableAtRange(_ range: Range<String.Index>, in string: String) -> Bool {
        guard !range.isEmpty else { return false }
        let nextIndex = range.upperBound
        guard string.endIndex > nextIndex else { return false }
        let nextCharacter = string[nextIndex]
        let variableNameCharacterSet = CharacterSet.letters + CharacterSet.decimalDigits + CharacterSet(arrayLiteral: "_")
        return nextCharacter.unicodeScalars.reduce(true, { return $0 && !variableNameCharacterSet.contains($1) })
    }
}

private extension CharacterSet {
    static func +(lhs: CharacterSet, rhs: CharacterSet) -> CharacterSet {
        var result = CharacterSet()
        result.formUnion(rhs)
        result.formUnion(lhs)
        return result
    }
}
