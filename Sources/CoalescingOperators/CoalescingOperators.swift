///
/// Coalescing Operators
/// v0.2
///
/// Created by Elaine Lyons
/// https://github.com/skjiisa/Coalescing-Operators
///

/** License
 This is free and unencumbered software released into the public domain.
 
 Anyone is free to copy, modify, publish, use, compile, sell, or
 distribute this software, either in source code form or as a compiled
 binary, for any purpose, commercial or non-commercial, and by any
 means.
 
 In jurisdictions that recognize copyright laws, the author or authors
 of this software dedicate any and all copyright interest in the
 software to the public domain. We make this dedication for the benefit
 of the public at large and to the detriment of our heirs and
 successors. We intend this dedication to be an overt act of
 relinquishment in perpetuity of all present and future rights to this
 software under copyright law.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 For more information, please refer to <https://unlicense.org>
 */

//MARK: ???

infix operator ???: NilCoalescingPrecedence

/// Performs an empty-coalescing operation, returning the non-empty value of either a
/// `Collection` or wrapped `Optional Collection` instance or a default value.
///
/// An empty-coalescing operation unwraps the left-hand side
/// `Collection` if it has a value and returns it if it is not empty, or
/// it returns the right-hand side as a default. The result of this operation
/// will have the non-optional type of the left-hand side's `Wrapped` type. It cannot
/// guarantee that the the result is not empty if the default value is empty, however.
///
/// This operator uses short-circuit evaluation: `optional` is checked first,
/// and `defaultValue` is evaluated only if `optional` is `nil` or empty. For example:
///
///     func getDefault() -> String {
///         print("Calculating default...")
///         return "New Item"
///     }
///
///     let name = "AB"
///
///     let goodName = String(name.dropLast()) ??? getDefault()
///     // goodName == "A"
///
///     let notSoGoodName = String(name.dropLast(2)) ??? getDefault()
///     // Prints "Calculating default..."
///     // notSoGoodName == "New Item"
///
/// In this example, `goodName` is assigned a value of `"A"` because
/// `name.dropLast()` succeeds in returning a non-empty result. When
/// `notSoGoodName` is initialized, `name.dropLast(2)` returns
/// an empty `String`, and so the `getDefault()` method is called
/// to supply a default value.
///
/// Because the result of this empty-coalescing operation
/// is itself may be empty, you can chain default values by using `???`
/// multiple times. The first value that isn't empty stops the chain and
/// becomes the result of the whole expression.
///
/// - Parameters:
///   - optional: An `Optional` or potentially empty `Collection`.
///   - defaultValue: A value to use as a default. `defaultValue` is the same
///     type as the `Wrapped` type of `optional`.
public func ??? <C: Collection>(optional: C?, defaultValue: @autoclosure () throws -> C) rethrows -> C {
    if let value = optional,
       !value.isEmpty {
        return value
    }
    return try defaultValue()
}

/// Performs an empty-coalescing operation, returning the non-empty value of either a
/// `Collection` or wrapped `Optional Collection` instance or a default `Optional` value.
///
/// An empty-coalescing operation unwraps the left-hand side
/// `Collection` if it has a value and returns it if it is not empty, or
/// it returns the right-hand side as a default. The result of this operation
/// will be the same type as its arguments.
///
/// This operator uses short-circuit evaluation: `optional` is checked first,
/// and `defaultValue` is evaluated only if `optional` is `nil` or empty. For example:
///
///     let name = "AB"
///     let number: Int? = 10
///
///     let goodName = String(name.dropLast()) ??? number?.description
///     print(goodName)
///     // Prints "Optional("A")"
///
///     let notSoGoodName = String(name.dropLast(2)) ??? number?.description
///     print(notSoGoodName)
///     // Prints "Optional("10")"
///
/// In this example, `goodName` is assigned a value of `"A"` because
/// `name.dropLast()` succeeds in returning a non-empty result. When
/// `notSoGoodName` is initialized, `name.dropLast(2)` returns
/// an empty `String`, and so `number?.description` is called
/// to supply a default value.
///
/// Because the result of this empty-coalescing operation is
/// itself an optional value that also may be empty, you can chain default values
/// by using `???` multiple times. The first optional value that isn't `nil` or
/// empty stops the chain and becomes the result of the whole expression.
///
/// - Parameters:
///   - optional: An `Optional` or potentially empty `Collection`.
///   - defaultValue: A value to use as a default. `defaultValue` is the same
///     type as the `Wrapped` type of `optional`.
public func ??? <C: Collection>(optional: C?, defaultValue: @autoclosure () throws -> C?) rethrows -> C? {
    if let value = optional,
       !value.isEmpty {
        return value
    }
    return try defaultValue()
}

/// Performs an empty-coalescing operation, returning the non-empty value of either a
/// `Collection` instance or a default value.
///
/// An empty-coalescing operation returns the left-hand side
/// `Collection` if it is not empty, or
/// it returns the right-hand side as a default. The result of this operation
/// will be the same type as its arguments. It cannot
/// guarantee that the the result is not empty if the default value is empty, however.
///
/// This operator uses short-circuit evaluation: `value` is checked first,
/// and `defaultValue` is evaluated only if `value` is empty. For example:
///
///     func getDefault() -> String {
///         print("Calculating default...")
///         return "New Item"
///     }
///
///     let name = "AB"
///
///     let goodName = String(name.dropLast()) ??? getDefault()
///     // goodName == "A"
///
///     let notSoGoodName = String(name.dropLast(2)) ??? getDefault()
///     // Prints "Calculating default..."
///     // notSoGoodName == "New Item"
///
/// In this example, `goodName` is assigned a value of `"A"` because
/// `name.dropLast()` succeeds in returning a non-empty result. When
/// `notSoGoodName` is initialized, `name.dropLast(2)` returns
/// an empty `String`, and so the `getDefault()` method is called
/// to supply a default value.
///
/// Because the result of this empty-coalescing operation
/// is itself may be empty, you can chain default values by using `???`
/// multiple times. The first value that isn't empty stops the chain and
/// becomes the result of the whole expression.
///
/// - Parameters:
///   - value: A potentially empty `Collection`.
///   - defaultValue: A value to use as a default. `defaultValue` is the same
///     type of `value`.
public func ??? <C: Collection>(value: C, defaultValue: @autoclosure () throws -> C) rethrows -> C {
    if !value.isEmpty {
        return value
    }
    return try defaultValue()
}

/// Performs an empty-coalescing operation, returning the non-empty value of a
/// `Collection` instance or a wrapped default `Optional` value.
///
/// An empty-coalescing operation returns the left-hand side
/// `Collection` if it is not empty, or
/// it returns the unwrapped right-hand side as a default if it has a value. The result of this operation
/// will be the same type as its left-hand side.
///
/// This operator uses short-circuit evaluation: `value` is checked first,
/// and `defaultValue` is evaluated only if `value` is or empty. For example:
///
///     let name = "AB"
///     let number: Int? = 10
///
///     let goodName = String(name.dropLast()) ??? number?.description
///     print(goodName)
///     // Prints "Optional("A")"
///
///     let notSoGoodName = String(name.dropLast(2)) ??? number?.description
///     print(notSoGoodName)
///     // Prints "Optional("10")"
///
/// In this example, `goodName` is assigned a value of `"A"` because
/// `name.dropLast()` succeeds in returning a non-empty result. When
/// `notSoGoodName` is initialized, `name.dropLast(2)` returns
/// an empty `String`, and so `number?.description` is called
/// to supply a default value.
///
/// Because the result of this empty-coalescing operation is
/// itself an optional value that also may be empty, you can chain default values
/// by using `???` multiple times. The first optional value that isn't `nil` or
/// empty stops the chain and becomes the result of the whole expression.
///
/// - Parameters:
///   - value: A potentially empty `Collection`.
///   - defaultValue: A value to use as a default. `defaultValue` is an `Optional` of the
///     type of `value`.
public func ??? <C: Collection>(value: C, defaultValue: @autoclosure () throws -> C?) rethrows -> C {
    if !value.isEmpty {
        return value
    }
    if let newValue = try defaultValue() {
        return newValue
    }
    return value
}

//MARK: ?=

infix operator ?=: NilCoalescingPrecedence

/// Performs a nil-coalescing assignment operation, returning the wrapped value of a mutable
/// `Optional` instance or assigning it to and returning a default value.
///
/// A nil-coalescing assignment operation unwraps the left-hand side if it has a value, or
/// assigns it to and returns the right-hand side as a default. The result of this operation
/// will have the non-optional type of the left-hand side's `Wrapped` type.
///
/// This operator uses short-circuit evaluation: `optional` is checked first,
/// and `defaultValue` is evaluated only if `optional` is `nil`.
/// Because `optional` is an `inout` property, it will trigger `didSet`
/// even if its value is not changed. For example:
///
///     func getDefault() -> Int {
///         print("Calculating default...")
///         return 42
///     }
///
///     var dict = ["One": 1] {
///         didSet {
///             print("dict updated")
///         }
///     }
///
///     let goodNumber = dict["One"] ?= getDefault()
///     // Prints "dict updated"
///     // goodNumber == 1
///     print(dict["One"])
///     // Prints "Optional(1)"
///
///     let notSoGoodNumber = dict["Forty-two"] ?= getDefault()
///     // Prints "Calculating default..."
///     // Prints "dict updated"
///     // notSoGoodNumber == 42
///     print(dict["Forty-two"])
///     // Prints "Optional(42)"
///
/// In this example, `goodNumber` is assigned a value of `1` and `dict["One"]` is
/// unchanged because `dict["One"]` succeeded in returning a non-`nil` result.
/// When `notSoGoodNumber` is initialized, `dict["Forty-two"]` returns
/// `nil`, and so the `getDefault()` method is called to supply a default
/// value which is assigned to `dict["Forty-two"]` and returned.
///
/// - Parameters:
///   - optional: An `Optional`, mutable value.
///   - defaultValue: A value to use as a default. `defaultValue` is the same
///     type as the `Wrapped` type of `optional`.
public func ?= <T>(optional: inout T?, defaultValue: @autoclosure () throws -> T) rethrows -> T {
    if let value = optional {
        return value
    }
    let newValue = try defaultValue()
    optional = newValue
    return newValue
}

/// Performs a nil-coalescing assignment operation, returning the wrapped value of a mutable
/// `Optional` instance or assigning it to and returning a default `Optional` value.
///
/// A nil-coalescing assignment operation unwraps the left-hand side if it has a value, or
/// assigns it to and returns the right-hand side as a default. The result of this operation
/// will be the same type as its arguments.
///
/// This operator uses short-circuit evaluation: `optional` is checked first,
/// and `defaultValue` is evaluated only if `optional` is `nil`.
/// Because `optional` is an `inout` property, it will trigger `didSet`
/// even if its value is not changed. For example:
///
///     func getDefault() -> Int {
///         print("Calculating default...")
///         return 42
///     }
///
///     var dict = ["One": 1] {
///         didSet {
///             print("dict updated")
///         }
///     }
///
///     let goodNumber = dict["One"] ?= getDefault()
///     // Prints "dict updated"
///     // goodNumber == 1
///     print(dict["One"])
///     // Prints "Optional(1)"
///
///     let notSoGoodNumber = dict["Forty-two"] ?= getDefault()
///     // Prints "Calculating default..."
///     // Prints "dict updated"
///     // notSoGoodNumber == 42
///     print(dict["Forty-two"])
///     // Prints "Optional(42)"
///
/// In this example, `goodNumber` is assigned a value of `1` and `dict["One"]` is
/// unchanged because `dict["One"]` succeeded in returning a non-`nil` result.
/// When `notSoGoodNumber` is initialized, `dict["Forty-two"]` returns
/// `nil`, and so the `getDefault()` method is called to supply a default
/// value which is assigned to `dict["Forty-two"]` and returned.
///
/// - Parameters:
///   - optional: An `Optional`, mutable value.
///   - defaultValue: A value to use as a default. `defaultValue` is the same
///     type as the `Wrapped` type of `optional`.
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

/// Performs an empty-coalescing assignment operation, returning the non-empty value
/// of a mutable property that is either an instance of or wrapped `Optional`
/// of `Collection` or assigning it to and returning a default value.
///
/// An empty-coalescing assignment operation unwraps the left-hand side
/// `Collection` if it has a value and returns it if it is not empty, or
/// assigns it to and returns the right-hand side as a default. The result of this operation
/// will have the non-optional type of the left-hand side's `Wrapped` type. It cannot
/// guarantee that the the result is not empty if the default value is empty, however.
///
/// This operator uses short-circuit evaluation: `optional` is checked first,
/// and `defaultValue` is evaluated only if `optional` is `nil` or empty.
/// Because `optional` is an `inout` property, it will trigger `didSet`
/// even if its value is not changed. For example:
///
///     func getDefault() -> String {
///         print("Calculating default...")
///         return "Apple"
///     }
///
///     var lastNames = ["John": "Smith", "Tim": ""] {
///         didSet {
///             print("lastNames updated")
///         }
///     }
///
///     let goodName = lastNames["John"] ??= getDefault()
///     // Prints "lastNames updated"
///     // goodName == "Smith"
///     print(lastNames["John"])
///     // Prints "Optional("Smith")"
///
///     let notSoGoodName = lastNames["Tim"] ??= getDefault()
///     // Prints "Calculating default..."
///     // Prints "lastNames updated"
///     // notSoGoodName == "Apple"
///     print(lastNames["Tim"])
///     // Prints "Optional("Apple")"
///
/// In this example, `goodName` is assigned a value of `"Smith"` and
/// `lastNames["John"]` is unchanged because `lastNames["John"]`
/// succeeds in returning a non-empty result. When `notSoGoodName` is
/// initialized, `lastNames["Tim"]` returns an empty `String`, and so the
/// `getDefault()` method is called to supply a default value which is
/// assigned to `lastNames["Tim"]` and returned.
///
/// - Parameters:
///   - optional: An `Optional` or potentially empty, mutable `Collection`.
///   - defaultValue: A value to use as a default. `defaultValue` is the same
///     type as the `Wrapped` type of `optional`.
public func ??= <C: Collection>(optional: inout C?, defaultValue: @autoclosure () throws -> C) rethrows -> C {
    if let value = optional,
       !value.isEmpty {
        return value
    }
    let newValue = try defaultValue()
    optional = newValue
    return newValue
}

/// Performs an empty-coalescing assignment operation, returning the non-empty value
/// of a mutable property that is either an instance of or wrapped `Optional`
/// of `Collection` or assigning it to and returning a default `Optional` value.
///
/// An empty-coalescing assignment operation unwraps the left-hand side
/// `Collection` if it has a value and returns it if it is not empty, or
/// assigns it to and returns the right-hand side as a default. The result of this operation
/// will be the same as its arguments. It cannot
/// guarantee that the the result is not empty if the default value is empty, however.
///
/// This operator uses short-circuit evaluation: `optional` is checked first,
/// and `defaultValue` is evaluated only if `optional` is `nil` or empty.
/// Because `optional` is an `inout` property, it will trigger `didSet`
/// even if its value is not changed. For example:
///
///     func getDefault() -> String {
///         print("Calculating default...")
///         return "Apple"
///     }
///
///     var lastNames = ["John": "Smith", "Tim": ""] {
///         didSet {
///             print("lastNames updated")
///         }
///     }
///
///     let goodName = lastNames["John"] ??= getDefault()
///     // Prints "lastNames updated"
///     // goodName == "Smith"
///     print(lastNames["John"])
///     // Prints "Optional("Smith")"
///
///     let notSoGoodName = lastNames["Tim"] ??= getDefault()
///     // Prints "Calculating default..."
///     // Prints "lastNames updated"
///     // notSoGoodName == "Apple"
///     print(lastNames["Tim"])
///     // Prints "Optional("Apple")"
///
/// In this example, `goodName` is assigned a value of `"Smith"` and
/// `lastNames["John"]` is unchanged because `lastNames["John"]`
/// succeeds in returning a non-empty result. When `notSoGoodName` is
/// initialized, `lastNames["Tim"]` returns an empty `String`, and so the
/// `getDefault()` method is called to supply a default value which is
/// assigned to `lastNames["Tim"]` and returned.
///
/// - Parameters:
///   - optional: An optional or potentially empty, mutable `Collection`.
///   - defaultValue: A value to use as a default. `defaultValue` is the same
///     type as `optional`.
public func ??= <C: Collection>(optional: inout C?, defaultValue: @autoclosure () throws -> C?) rethrows -> C? {
    if let value = optional,
       !value.isEmpty {
        return value
    }
    // If `optional` is nil and `defaultValue` is an empty Collection,
    // should this return nil or the empty Collection?
    if let newValue = try defaultValue(),
       !newValue.isEmpty {
        // Only write to `optional` if `defaultValue`
        // itself also isn't nil or empty.
        optional = newValue
        return newValue
    }
    // I think it could make sense for this to return an empty
    // C instead of nil, but I'm not sure how to do that.
    return optional
}

/// Performs an empty-coalescing assignment operation, returning the non-empty value
/// of a mutable property that is either an instance
/// of `Collection` or assigning it to and returning a default value.
///
/// An empty-coalescing assignment operation returns the left-hand side
/// `Collection` if it is not empty, or
/// assigns it to and returns the right-hand side as a default. The result of this operation
/// will be the same as its arguments. It cannot
/// guarantee that the the result is not empty if the default value is empty, however.
///
/// This operator uses short-circuit evaluation: `optional` is checked first,
/// and `defaultValue` is evaluated only if `optional` is `nil` or empty.
/// Because `optional` is an `inout` property, it will trigger `didSet`
/// even if its value is not changed. For example:
///
///     func getDefault() -> String {
///         print("Calculating default...")
///         return "Apple"
///     }
///
///     var lastNames = ["John": "Smith", "Tim": ""] {
///         didSet {
///             print("lastNames updated")
///         }
///     }
///
///     let goodName = lastNames["John"] ??= getDefault()
///     // Prints "lastNames updated"
///     // goodName == "Smith"
///     print(lastNames["John"])
///     // Prints "Optional("Smith")"
///
///     let notSoGoodName = lastNames["Tim"] ??= getDefault()
///     // Prints "Calculating default..."
///     // Prints "lastNames updated"
///     // notSoGoodName == "Apple"
///     print(lastNames["Tim"])
///     // Prints "Optional("Apple")"
///
/// In this example, `goodName` is assigned a value of `"Smith"` and
/// `lastNames["John"]` is unchanged because `lastNames["John"]`
/// succeeds in returning a non-empty result. When `notSoGoodName` is
/// initialized, `lastNames["Tim"]` returns an empty `String`, and so the
/// `getDefault()` method is called to supply a default value which is
/// assigned to `lastNames["Tim"]` and returned.
///
/// - Parameters:
///   - value: A potentially empty, mutable `Collection`.
///   - defaultValue: A value to use as a default. `defaultValue` is the same
///     type as `value`.
public func ??= <C: Collection>(value: inout C, defaultValue: @autoclosure () throws -> C) rethrows -> C {
    if !value.isEmpty {
        return value
    }
    let newValue = try defaultValue()
    if !newValue.isEmpty {
        value = newValue
        return newValue
    }
    return value
}

/// Performs an empty-coalescing assignment operation, returning the non-empty value
/// of a mutable property that is either an instance
/// of `Collection` or assigning it to and returning a default unwrapped `Optional` value.
///
/// An empty-coalescing assignment operation returns the left-hand side
/// `Collection` if it is not empty, or
/// assigns it to and returns the right-hand side as a default. The result of this operation
/// will be the same as its left-hand side. It cannot
/// guarantee that the the result is not empty if the default value is `nil` or empty, however.
///
/// This operator uses short-circuit evaluation: `optional` is checked first,
/// and `defaultValue` is evaluated only if `optional` is `nil` or empty.
/// Because `optional` is an `inout` property, it will trigger `didSet`
/// even if its value is not changed. For example:
///
///     func getDefault() -> String {
///         print("Calculating default...")
///         return "Apple"
///     }
///
///     var lastNames = ["John": "Smith", "Tim": ""] {
///         didSet {
///             print("lastNames updated")
///         }
///     }
///
///     let goodName = lastNames["John"] ??= getDefault()
///     // Prints "lastNames updated"
///     // goodName == "Smith"
///     print(lastNames["John"])
///     // Prints "Optional("Smith")"
///
///     let notSoGoodName = lastNames["Tim"] ??= getDefault()
///     // Prints "Calculating default..."
///     // Prints "lastNames updated"
///     // notSoGoodName == "Apple"
///     print(lastNames["Tim"])
///     // Prints "Optional("Apple")"
///
/// In this example, `goodName` is assigned a value of `"Smith"` and
/// `lastNames["John"]` is unchanged because `lastNames["John"]`
/// succeeds in returning a non-empty result. When `notSoGoodName` is
/// initialized, `lastNames["Tim"]` returns an empty `String`, and so the
/// `getDefault()` method is called to supply a default value which is
/// assigned to `lastNames["Tim"]` and returned.
///
/// - Parameters:
///   - value: An potentially empty, mutable `Collection`.
///   - defaultValue: A value to use as a default. `defaultValue`
///      is an `Optional` with the wrapped type of that of `value`.
public func ??= <C: Collection>(value: inout C, defaultValue: @autoclosure () throws -> C?) rethrows -> C {
    if !value.isEmpty {
        return value
    }
    if let newValue = try defaultValue(),
       !newValue.isEmpty {
        // Only write to `optional` if `defaultValue`
        // itself also isn't nil or empty.
        value = newValue
        return newValue
    }
    return value
}
