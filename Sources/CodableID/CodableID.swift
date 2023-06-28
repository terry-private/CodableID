@attached(member, names: named(ID))
public macro CodableID<T>(_: T.Type) = #externalMacro(module: "CodableIDMacros", type: "CodableID")
