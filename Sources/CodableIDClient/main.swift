import CodableID

@CodableID(Int.Type)
struct Person: Codable {
    var id: ID
    var name: String
}

let person: Person = .init(id: .init(rawValue: 0), name: "hoge")
