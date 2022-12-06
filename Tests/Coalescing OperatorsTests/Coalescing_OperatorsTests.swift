import XCTest
@testable import Coalescing_Operators

final class Coalescing_OperatorsTests: XCTestCase {
    
    //MARK: - ??? optional, non-optional
    
    func testEmptyCoalescingOptionalNonOptionalNilLeft() {
        let expected: [Int] = [1, 2, 3]
        let actual: [Int] = nil ??? expected
        XCTAssertEqual(actual, expected)
    }
    
    func testEmptyCoalescingOptionalNonOptionalEmptyLeft() {
        let expected: [Int] = [1, 2, 3]
        let actual: [Int] = Optional<[Int]>([]) ??? expected
        XCTAssertEqual(actual, expected)
    }
    
    func testEmptyCoalescingOptionalNonOptionalValidLeft() {
        var defaultCalled = false
        func defaultValue() -> [Int] {
            defaultCalled = true
            return [1, 2, 3, 4, 5]
        }
        
        let expected: [Int]? = [1, 2, 3]
        let actual: [Int] = expected ??? defaultValue()
        
        XCTAssertEqual(actual, expected)
        XCTAssertFalse(defaultCalled)
    }
    
    //MARK: ??? optional, optional
    
    func testEmptyCoalescingOptionalOptionalNilLeft() {
        let expected: [Int]? = [1, 2, 3]
        let actual: [Int]? = nil ??? expected
        XCTAssertEqual(actual, expected)
    }
    
    func testEmptyCoalescingOptionalOptionalEmptyLeft() {
        let expected: [Int]? = [1, 2, 3]
        let actual: [Int]? = Optional<[Int]>([]) ??? expected
        XCTAssertEqual(actual, expected)
    }
    
    func testEmptyCoalescingOptionalOptionalValidLeft() {
        var defaultCalled = false
        func defaultValue() -> [Int]? {
            defaultCalled = true
            return [1, 2, 3, 4, 5]
        }
        
        let expected: [Int]? = [1, 2, 3]
        let actual: [Int]? = expected ??? defaultValue()
        
        XCTAssertEqual(actual, expected)
        XCTAssertFalse(defaultCalled)
    }
    
    //MARK: - ??? non-optional, non-optional
    
    func testEmptyCoalescingNonOptionalNonOptionalEmptyLeft() {
        let expected: [Int] = [1, 2, 3]
        let actual: [Int] = [] ??? expected
        XCTAssertEqual(actual, expected)
    }
    
    func testEmptyCoalescingNonOptionalNonOptionalValidLeft() {
        var defaultCalled = false
        func defaultValue() -> [Int] {
            defaultCalled = true
            return [1, 2, 3, 4, 5]
        }
        
        let expected: [Int] = [1, 2, 3]
        let actual: [Int] = expected ??? defaultValue()
        
        XCTAssertEqual(actual, expected)
        XCTAssertFalse(defaultCalled)
    }
    
    //MARK: ??? non-optonal, optional
    
    func testEmptyCoalescingNonOptionalOptionalEmptyLeftValidRight() {
        let expected: [Int]? = [1, 2, 3]
        let actual: [Int] = [] ??? expected
        XCTAssertEqual(actual, expected)
    }
    
    func testEmptyCoalescingNonOptionalOptionalEmptyLeftNilRight() {
        let expected: [Int] = []
        let actual: [Int] = expected ??? nil
        XCTAssertEqual(actual, expected)
    }
    
    func testEmptyCoalescingNonOptionalOptionalValidLeft() {
        var defaultCalled = false
        func defaultValue() -> [Int]? {
            defaultCalled = true
            return [1, 2, 3, 4, 5]
        }
        
        let expected: [Int] = [1, 2, 3]
        let actual: [Int] = expected ??? defaultValue()
        
        XCTAssertEqual(actual, expected)
        XCTAssertFalse(defaultCalled)
    }
    
    //MARK: - ?= non-optional
    
    func testNilCoalescingAssignmentNonOptionalNilLeft() {
        var actual: String?
        let expected: String = UUID().uuidString
        let final = actual ?= expected
        
        // actual should be reassigned
        XCTAssertEqual(actual, expected)
        XCTAssertEqual(final, expected)
    }
    
    func testNilCoalescingAssignmentNonOptionalValidLeft() {
        var defaultCalled = false
        func defaultValue() -> String {
            defaultCalled = true
            return UUID().uuidString
        }
        
        var actual: String? = UUID().uuidString
        let final = actual ?= defaultValue()
        
        // actual should be unchanged
        XCTAssertEqual(actual, final)
        XCTAssertFalse(defaultCalled)
    }
    
    //MARK: ?= optional
    
    func testNilCoalescingAssignmentOptionalNilLeft() {
        var actual: String?
        let expected: String? = UUID().uuidString
        let final = actual ?= expected
        // actual should be reassigned
        XCTAssertEqual(actual, expected)
        XCTAssertEqual(final, expected)
    }
    
    func testNilCoalescingAssignmentOptionalValidLeft() {
        var defaultCalled = false
        func defaultValue() -> String? {
            defaultCalled = true
            return UUID().uuidString
        }
        
        
        var actual: String? = UUID().uuidString
        let final = actual ?= defaultValue()
        // actual should be unchanged
        XCTAssertEqual(actual, final)
        XCTAssertFalse(defaultCalled)
    }
    
    func testNilCoalescingAssignmentOptionalBothNil() {
        var actual: String?
        let final = actual ?= nil
        XCTAssertNil(actual)
        XCTAssertNil(final)
    }
    
}
