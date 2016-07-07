//
//  StyledButtonSpec.swift
//  align
//
//  Created by Ben Norris on 7/5/16.
//  Copyright © 2016 OC Tanner. All rights reserved.
//

//import XCTest
//import Nimble
//@testable import align
//
//class StyledButtonSpec: XCTestCase {
//    
//    var button: StyledButton!
//    
//    override func setUp() {
//        super.setUp()
//        button = StyledButton()
//    }
//    
//    /// test that it initializes with expected values
//    func testThatItInitializesWithExpectedValues() {
//        let view = button
//        expect(view.titleColorForState(.Normal)) == UIColor.whiteColor()
//        expect(view.backgroundColorName).to(beNil())
//        expect(view.backgroundColor).to(beNil())
//        expect(view.tintColorName).to(beNil())
//        expect(view.tintColor) == UIColor(hex: 0x007AFF)
//        expect(view.borderColorName).to(beNil())
//        expect(UIColor(CGColor: view.layer.borderColor!).hexString) == "000000"
//        expect(view.borderWidth) == 0.0
//        expect(view.layer.borderWidth) == view.borderWidth
//        expect(view.cornerRadius) == 0.0
//        expect(view.layer.cornerRadius) == view.cornerRadius
//        expect(view.circular) == false
//    }
//    
//    /// test that it adjusts the title color when the name is set
//    func testThatItAdjustsTheTitleColorWhenTheNameIsSet() {
//        button.titleColorName = "primaryText"
//        expect(self.button.titleColorForState(.Normal)) == UIColor(hex: 0x1D1E1D)
//    }
//    
//    /// test that it raises an exception to use an invalid title color name
//    func testThatItRaisesAnExceptionToUseAnInvalidTitleColorName() {
//        expect(self.button.titleColorName = "invalid color name").to(raiseException())
//    }
//    
//    /// test that it does nothing to set the title color name to nil
//    func testThatItDoesNothingToSetTheTitleColorNameToNil() {
//        expect(self.button.titleColorForState(.Normal)) == UIColor.whiteColor()
//        button.titleColorName = "secondaryText"
//        expect(self.button.titleColorForState(.Normal)) == UIColor(hex: 0x72797C)
//        button.titleColorName = nil
//        expect(self.button.titleColorForState(.Normal)) == UIColor(hex: 0x72797C)
//    }
//
//    /// test that it adjusts the background color when the name is set
//    func testThatItAdjustsTheBackgroundColorWhenTheNameIsSet() {
//        button.backgroundColorName = "backgroundFill"
//        expect(self.button.backgroundColor) == UIColor(hex: 0xFAFBFB)
//    }
//    
//    /// test that it raises an exception to use an invalid background color name
//    func testThatItRaisesAnExceptionToUseAnInvalidBackgroundColorName() {
//        expect(self.button.backgroundColorName = "invalid color name").to(raiseException())
//    }
//    
//    /// test that it sets the background color to nil when setting the background color name to nil
//    func testThatItSetsTheBackgroundColorToNilWhenSettingTheBackgroundColorNameToNil() {
//        expect(self.button.backgroundColor).to(beNil())
//        button.backgroundColorName = "primaryAction"
//        expect(self.button.backgroundColor) == UIColor(hex: 0x0DC6FF)
//        button.backgroundColorName = nil
//        expect(self.button.backgroundColor).to(beNil())
//    }
//
//    /// test that it adjusts the tint color when the name is set
//    func testThatItAdjustsTheTintColorWhenTheNameIsSet() {
//        button.tintColorName = "primaryText"
//        expect(self.button.tintColor) == UIColor(hex: 0x1D1E1D)
//    }
//    
//    /// test that it raises an exception to use an invalid tint color name
//    func testThatItRaisesAnExceptionToUseAnInvalidTintColorName() {
//        expect(self.button.tintColorName = "invalid color name").to(raiseException())
//    }
//    
//    /// test that it sets the tint color to default when setting the tint color name to nil
//    func testThatItSetsTheTintColorToDefaultWhenSettingTheTintColorNameToNil() {
//        expect(self.button.tintColor) == UIColor(hex: 0x007AFF)
//        button.tintColorName = "inactiveAction"
//        expect(self.button.tintColor) == UIColor(hex: 0xC9D1D3)
//        button.tintColorName = nil
//        expect(self.button.tintColor) == UIColor(hex: 0x007AFF)
//    }
//
//    /// test that it adjusts the border color when the name is set
//    func testThatItAdjustsTheBorderColorWhenTheNameIsSet() {
//        button.borderColorName = "primaryText"
//        expect(UIColor(CGColor: self.button.layer.borderColor!).hexString) == "1d1e1d"
//    }
//    
//    /// test that it raises an exception to use an invalid border color name
//    func testThatItRaisesAnExceptionToUseAnInvalidBorderColorName() {
//        expect(self.button.borderColorName = "invalid color name").to(raiseException())
//    }
//    
//    /// test that it does nothing to set the border color name to nil
//    func testThatItDoesNothingToSetTheBorderColorNameToNil() {
//        expect(UIColor(CGColor: self.button.layer.borderColor!).hexString) == "000000"
//        button.borderColorName = "borderStroke"
//        expect(UIColor(CGColor: self.button.layer.borderColor!).hexString) == "e8eced"
//        button.borderColorName = nil
//        expect(UIColor(CGColor: self.button.layer.borderColor!).hexString) == "e8eced"
//    }
//
//    /// test that it adjusts the layer border width when the border width is changed
//    func testThatItAdjustsTheLayerBorderWidthWhenTheBorderWidthIsChanged() {
//        button.borderWidth = 2.0
//        expect(self.button.layer.borderWidth) == 2.0
//    }
//    
//    /// test that it adjusts the layer corner radius when the corner radius is changed
//    func testThatItAdjustsTheLayerCornerRadiusWhenTheCornerRadiusIsChanged() {
//        button.cornerRadius = 4.0
//        expect(self.button.layer.cornerRadius) == 4.0
//    }
//    
//    /// test that it applies the correct corner radius on a circular view
//    func testThatItAppliesTheCorrectCornerRadiusOnACircularView() {
//        button.frame = CGRectMake(0, 0, 40.0, 20.0)
//        button.circular = true
//        expect(self.button.layer.cornerRadius) == 10.0
//    }
//    
//}
