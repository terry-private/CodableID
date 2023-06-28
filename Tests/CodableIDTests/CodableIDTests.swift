import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import CodableIDMacros


final class CodableIDTests: XCTestCase {
    let testMacros: [String: Macro.Type] = [
        "CodableID": CodableID.self,
    ]
    func testMacro() {
        let codableIDSyntax: SourceFileSyntax = #"""
                @CodableID(Int.self)
                struct Person: Codable {
                    var id: ID
                    var name: String
                }
            """#
        let context = BasicMacroExpansionContext(sourceFiles: [codableIDSyntax: .init(moduleName: "CodableIDMacros", fullFilePath: "test.swift")])
        let transformed = codableIDSyntax.expand(macros: testMacros, in: context)
        
        XCTAssertEqual(
          transformed.description,
          #"""

              struct Person: Codable {
                  var id: ID
                  var name: String
              public struct ID: RawRepresentable, Codable {
                public var rawValue: Int
                public init(rawValue: Int) {
                  self.rawValue = rawValue
                }
              }
              }
          """#
        )
        
    }
}
