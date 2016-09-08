/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import XCTest
@testable import SharedHelpers

class SemanticVersionSpec: XCTestCase {
    
    // MARK: - Initialization tests
    
    /// test that it is initialized properly with major
    func testThatItIsInitializedProperlyWithMajor() {
        let version = SemanticVersion("1")
        XCTAssertNotNil(version)
        XCTAssertEqual(version?.major, 1)
        XCTAssertEqual(version?.minor, 0)
        XCTAssertEqual(version?.patch, 0)
    }
    
    /// test that it is initialized properly with major and minor
    func testThatItIsInitializedProperlyWithMajorAndMinor() {
        let version = SemanticVersion("1.1")
        XCTAssertNotNil(version)
        XCTAssertEqual(version?.major, 1)
        XCTAssertEqual(version?.minor, 1)
        XCTAssertEqual(version?.patch, 0)
    }
    
    /// test that it is initialized properly with major and minor and patch
    func testThatItIsInitializedProperlyWithMajorAndMinorAndPatch() {
        let version = SemanticVersion("1.1.1")
        XCTAssertNotNil(version)
        XCTAssertEqual(version?.major, 1)
        XCTAssertEqual(version?.minor, 1)
        XCTAssertEqual(version?.patch, 1)
    }
    
    /// test that it is nil with invalid
    func testThatItIsNilWithInvalid() {
        let nilVersion = SemanticVersion("Major")
        XCTAssertNil(nilVersion)
    }
    
    
    // MARK: - Description tests
    
    /// test that it has the correct description with major
    func testThatItHasTheCorrectDescriptionWithMajor() {
        let version = SemanticVersion("1")
        XCTAssertEqual(version?.description, "1.0.0")
    }
    
    /// test that it has the correct description with major and minor
    func testThatItHasTheCorrectDescriptionWithMajorAndMinor() {
        let version = SemanticVersion("1.1")
        XCTAssertEqual(version?.description, "1.1.0")
    }

    /// test that it has the correct description with major and minor and patch
    func testThatItHasTheCorrectDescriptionWithMajorAndMinorAndPatch() {
        let version = SemanticVersion("1.1.1")
        XCTAssertEqual(version?.description, "1.1.1")
    }
    
    
    // MARK: - Equality tests
    
    /// test that it is equal with matching major
    func testThatItIsEqualWithMatchingMajor() {
        let firstVersion = SemanticVersion("1")
        let secondVersion = SemanticVersion("1")
        XCTAssertEqual(firstVersion, secondVersion)
    }
    
    /// test that it is equal with matching major and minor
    func testThatItIsEqualWithMatchingMajorAndMinor() {
        let firstVersion = SemanticVersion("1.1")
        let secondVersion = SemanticVersion("1.1")
        XCTAssertEqual(firstVersion, secondVersion)
    }
    
    /// test that it is not equal with matching major and different minor
    func testThatItIsNotEqualWithMatchingMajorAndDifferentMinor() {
        let firstVersion = SemanticVersion("1")
        let secondVersion = SemanticVersion("1.1")
        XCTAssertNotEqual(firstVersion, secondVersion)
    }
    
    /// test that it is not equal with different major
    func testThatItIsNotEqualWithDifferentMajor() {
        let firstVersion = SemanticVersion("1")
        let secondVersion = SemanticVersion("2")
        XCTAssertNotEqual(firstVersion, secondVersion)
    }
    
    /// test that it is equal with matching major and minor and patch
    func testThatItIsEqualWithMatchingMajorAndMinorAndPatch() {
        let firstVersion = SemanticVersion("1.1.1")
        let secondVersion = SemanticVersion("1.1.1")
        XCTAssertEqual(firstVersion, secondVersion)
    }
    
    /// test that it not equal with matching major and minor and different patch
    func testThatItNotEqualWithMatchingMajorAndMinorAndDifferentPatch() {
        let firstVersion = SemanticVersion("1.1")
        let secondVersion = SemanticVersion("1.1.1")
        XCTAssertNotEqual(firstVersion, secondVersion)
    }
    
    /// test that it is not equal with matching major and patch and different minor
    func testThatItIsNotEqualWithMatchingMajorAndPatchAndDifferentMinor() {
        let firstVersion = SemanticVersion("1.0.1")
        let secondVersion = SemanticVersion("1.1.1")
        XCTAssertNotEqual(firstVersion, secondVersion)
    }
    
    /// test that it is not equal with matching major and different minor and patch
    func testThatItIsNotEqualWithMatchingMajorAndDifferentMinorAndPatch() {
        let firstVersion = SemanticVersion("1")
        let secondVersion = SemanticVersion("1.1.1")
        XCTAssertNotEqual(firstVersion, secondVersion)
    }
    
    /// test that it is not equal with matching minor and patch and different major
    func testThatItIsNotEqualWithMatchingMinorAndPatchAndDifferentMajor() {
        let firstVersion = SemanticVersion("1.1.1")
        let secondVersion = SemanticVersion("2.1.1")
        XCTAssertNotEqual(firstVersion, secondVersion)
    }
    
    /// test that it is not equal with matching minor and different major and patch
    func testThatItIsNotEqualWithMatchingMinorAndDifferentMajorAndPatch() {
        let firstVersion = SemanticVersion("1.1")
        let secondVersion = SemanticVersion("2.1.1")
        XCTAssertNotEqual(firstVersion, secondVersion)
    }
    
    /// test that it is not equal with matching patch and different major and minor
    func testThatItIsNotEqualWithMatchingPatchAndDifferentMajorAndMinor() {
        let firstVersion = SemanticVersion("1.1.1")
        let secondVersion = SemanticVersion("2.2.1")
        XCTAssertNotEqual(firstVersion, secondVersion)
    }
    
    /// test that it is not equal with different major and minor and patch
    func testThatItIsNotEqualWithDifferentMajorAndMinorAndPatch() {
        let firstVersion = SemanticVersion("1.1.1")
        let secondVersion = SemanticVersion("2.2.2")
        XCTAssertNotEqual(firstVersion, secondVersion)
    }
    
    
    // MARK: - Comparison tests
    
    /// test that it is less with smaller major
    func testThatItIsLessWithSmallerMajor() {
        let firstVersion = SemanticVersion("1")!
        let secondVersion = SemanticVersion("2")!
        XCTAssertLessThan(firstVersion, secondVersion)
    }
    
    /// test that it is less with smaller major and minor
    func testThatItIsLessWithSmallerMajorAndMinor() {
        let firstVersion = SemanticVersion("1")!
        let secondVersion = SemanticVersion("2.1")!
        XCTAssertLessThan(firstVersion, secondVersion)
    }
    
    /// test that it is less with smaller major and minor and patch
    func testThatItIsLessWithSmallerMajorAndMinorAndPatch() {
        let firstVersion = SemanticVersion("1")!
        let secondVersion = SemanticVersion("2.1.1")!
        XCTAssertLessThan(firstVersion, secondVersion)
    }
    
    /// test that it is less with matching major and smaller minor
    func testThatItIsLessWithMatchingMajorAndSmallerMinor() {
        let firstVersion = SemanticVersion("1")!
        let secondVersion = SemanticVersion("1.1")!
        XCTAssertLessThan(firstVersion, secondVersion)
    }
    
    /// test that it is less with matching major and smaller minor and patch
    func testThatItIsLessWithMatchingMajorAndSmallerMinorAndPatch() {
        let firstVersion = SemanticVersion("1")!
        let secondVersion = SemanticVersion("1.1.1")!
        XCTAssertLessThan(firstVersion, secondVersion)
    }

    /// test that it is less with matching major and minor and smaller patch
    func testThatItIsLessWithMatchingMajorAndMinorAndSmallerPatch() {
        let firstVersion = SemanticVersion("1.1")!
        let secondVersion = SemanticVersion("1.1.1")!
        XCTAssertLessThan(firstVersion, secondVersion)
    }
    
    /// test that it is not less with matching major and minor and patch
    func testThatItIsNotLessWithMatchingMajorAndMinorAndPatch() {
        let firstVersion = SemanticVersion("1.1.1")!
        let secondVersion = SemanticVersion("1.1.1")!
        XCTAssertFalse(firstVersion < secondVersion)
    }
    
}
