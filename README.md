# Coalescing Operators

Custom Coalescing Operators Swift Package

+ `???` empty-coalescing operator
    + Returns a default value if the original is either `nil` or an empty `Collection` (such as `Array` or `String`)
+ `?=` nil-coalescing assignment operator
    + Assigns and returns a default value if the original is `nil`
+ `??=` empty-coalescing assignment operator
    + Assigns and returns a default value if the original is `nil` or an empty `Collection`

Examples of each included below

## Installation

Add to your project with Swift Package Manager, or simply download and include [CoalescingOperators.swift](Sources/CoalescingOperators/CoalescingOperators.swift) directly.

## Usage

### `???`

The empty-coalescing operator returns the non-empty value of either a `Collection` or wrapped `Optional Collection` instance or a provided default value.

Put simply, it works like `??` but apples to empty collections, such as arrays or strings.

#### Example

```swift
func getDefault() -> String {
    print("Calculating default...")
    return "New Item"
}

let name = "AB"

let goodName = String(name.dropLast()) ??? getDefault()
// goodName == "A"

let notSoGoodName = String(name.dropLast(2)) ??? getDefault()
// Prints "Calculating default..."
// notSoGoodName == "New Item"
```

Note that there is no guarantee that the provided default value is itself not empty.
It can, however, be chained, similarly to `??`, in order to account for that case.

```swift
var noString: String?
var emptyString = ""

let validString: String = noString ??? emptyString ??? "Unknown"
// validString == "Unknown"
```

### `?=`

The nil-coalescing assignment operator returns the wrapped value of a mutable `Optional` instance or assigns it to and returns a provided default value.

Put simply, it works like `??`, but it assigns the original property to the new default value.
This can be especially useful when working with dictionaries.

#### Example

```swift
class NeworkingController {
    let endpoint: String
    // ...
}

class Coordinator {
    var controllers: [String: NeworkingController] = [:]
    
    func controller(for endpoint: String) -> NeworkingController {
        controllers[endpoint] ?= NeworkingController(endpoint: endpoint)
    }
}
```

In this example, we want exacly one `NeworkingController` per endpoint.
We use the `Coordinator` to keep track of these controllers.
In `controller(for:)`, `?=` allows us to return the existing `NeworkingController` for the endpoint if it already exists, or easily create, store, and return a new controller if it doesn't.

Note that by nature of having an `inout` property, the original property will have its `didSet` called, even if the default value is never computed and the property is never changed.

```swift
func getDefault() -> Int {
    print("Calculating default...")
    return 42
}

var number: Int? = 1 {
    didSet {
        print("dict updated")
    }
}

let goodNumber = number ?= getDefault()
// Prints "dict updated"
// goodNumber == 1
print(number)
// Prints "Optional(1)"
```

`"dict updated"` is printed even though `"Calculating default..."` never is.

### `??=`

The empty-coalescing assignment operator returns the non-empty value of a mutable property that is either an instance of or wrapped `Optional` of `Collection` or assigns it to and returns a default value.

It's basically `?=` and `???` combined.

#### Example

```swift
func getDefault() -> String {
    print("Calculating default...")
    return "Apple"
}

var lastNames = ["Jane": "Doe", "Tim": ""] {
    didSet {
        print("lastNames updated")
    }
}

let name1 = lastNames["Jane"] ??= getDefault()
// Prints "lastNames updated"
// name1 == "Doe"
print(lastNames["Jane"])
// Prints "Optional("Doe")"

let name2 = lastNames["Tim"] ??= getDefault()
// Prints "Calculating default..."
// Prints "lastNames updated"
// name2 == "Apple"
print(lastNames["Tim"])
// Prints "Optional("Apple")"
```

Note that, similarly to `?=`, by nature of having an `inout` property, the original property will have its `didSet` called, even if the default value is never computed and the property is never changed.

## License

This project is open-source and released to the public domain under [The Unlicense](LICENSE).
