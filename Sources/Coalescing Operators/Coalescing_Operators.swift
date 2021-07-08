//MARK: ???

infix operator ???: NilCoalescingPrecedence

public func ??? <C: Collection>(optional: C?, defaultValue: @autoclosure () throws -> C) rethrows -> C {
    if let value = optional,
       !value.isEmpty {
        return value
    }
    return try defaultValue()
}

public func ??? <C: Collection>(optional: C?, defaultValue: @autoclosure () throws -> C?) rethrows -> C? {
    if let value = optional,
       !value.isEmpty {
        return value
    }
    return try defaultValue()
}

//MARK: ?=

infix operator ?=: NilCoalescingPrecedence

public func ?= <T>(optional: inout T?, defaultValue: @autoclosure () throws -> T) rethrows -> T {
    if let value = optional {
        return value
    }
    let newValue = try defaultValue()
    optional = newValue
    return newValue
}

public func ?= <T>(optional: inout T?, defaultValue: @autoclosure () throws -> T?) rethrows -> T? {
    if let value = optional {
        return value
    }
    if let newValue = try defaultValue() {
        // Only write to `optional` if
        // `defaultValue` itself also isn't nil.
        optional = newValue
        return newValue
    }
    return nil
}

//MARK: ??=

infix operator ??=: NilCoalescingPrecedence

public func ??= <C: Collection>(optional: inout C?, defaultValue: @autoclosure () throws -> C) rethrows -> C {
    if let value = optional,
       !value.isEmpty {
        return value
    }
    let newValue = try defaultValue()
    optional = newValue
    return newValue
}

public func ??= <C: Collection>(optional: inout C?, defaultValue: @autoclosure () throws -> C?) rethrows -> C? {
    if let value = optional,
       !value.isEmpty {
        return value
    }
    if let newValue = try defaultValue(),
       !newValue.isEmpty {
        // Only write to `optional` if `defaultValue`
        // itself also isn't nil or empty.
        optional = newValue
        return newValue
    }
    return optional
}

