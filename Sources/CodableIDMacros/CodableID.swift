import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct CodableID: MemberMacro {
    public static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard
          case .argumentList(let arguments) = node.argument,
          arguments.count == 1,
          let memberAccessExn = arguments.first?
            .expression.as(MemberAccessExprSyntax.self),
          let rawType = memberAccessExn.base?.as(IdentifierExprSyntax.self)
        else {
            fatalError("compiler bug: the macro does not have any arguments")
        }
        let idSyntax: DeclSyntax = """
        
            public struct ID: RawRepresentable, Codable {
              public var rawValue: \(rawType)
              public init(rawValue: \(rawType)) {
                self.rawValue = rawValue
              }
            }
        
        """
        return [idSyntax]
    }
}

@main
struct CodableIDPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        CodableID.self,
    ]
}
