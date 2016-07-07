//
//  StyledLabelSpec.swift
//  align
//
//  Created by Ben Norris on 7/5/16.
//  Copyright © 2016 OC Tanner. All rights reserved.
//

//import XCTest
//import Nimble
//@testable import align
//
//class StyledLabelSpec: XCTestCase {
//    
//    var label: StyledLabel!
//    
//    override func setUp() {
//        super.setUp()
//        label = StyledLabel()
//    }
//    
//    /// test that it initializes with expected values
//    func testThatItInitializesWithExpectedValues() {
//        expect(self.label.textColorName) == "primaryText"
//        expect(self.label.textColor) == UIColor(hex: 0x1D1E1D)
//    }
//    
//    /// test that it correctly sets the text color with a valid color name
//    func testThatItCorrectlySetsTheTextColorWithAValidColorName() {
//        expect(self.label.textColor) == UIColor(hex: 0x1D1E1D)
//        label.textColorName = "secondaryText"
//        expect(self.label.textColor) == UIColor(hex: 0x72797C)
//    }
//    
//    /// test that it raises an exception to use an invalid color name
//    func testThatItRaisesAnExceptionToUseAnInvalidColorName() {
//        expect(self.label.textColorName = "invalid color name").to(raiseException())
//    }
//    
//    /// test that it does nothing to set the color name to nil
//    func testThatItDoesNothingToSetTheColorNameToNil() {
//        expect(self.label.textColor) == UIColor(hex: 0x1D1E1D)
//        label.textColorName = "secondaryText"
//        expect(self.label.textColor) == UIColor(hex: 0x72797C)
//        label.textColorName = nil
//        expect(self.label.textColor) == UIColor(hex: 0x72797C)
//    }
//    
//}
