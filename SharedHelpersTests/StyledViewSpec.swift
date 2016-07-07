//
//  StyledViewSpec.swift
//  align
//
//  Created by Ben Norris on 7/5/16.
//  Copyright © 2016 OC Tanner. All rights reserved.
//

//import XCTest
//import Nimble
//@testable import align
//
//class StyledViewSpec: XCTestCase {
//    
//    var view: StyledView!
//    
//    override func setUp() {
//        super.setUp()
//        view = StyledView()
//    }
//    
//    /// test that it initializes with expected values
//    func testThatItInitializesWithExpectedValues() {
//        let styledView = view
//        expect(styledView.backgroundColorName).to(beNil())
//        expect(styledView.backgroundColor).to(beNil())
//        expect(styledView.tintColorName).to(beNil())
//        expect(styledView.tintColor) == UIColor(hex: 0x007AFF)
//        expect(styledView.borderColorName).to(beNil())
//        expect(UIColor(CGColor: styledView.layer.borderColor!).hexString) == "000000"
//        expect(styledView.borderWidth) == 0.0
//        expect(styledView.layer.borderWidth) == styledView.borderWidth
//        expect(styledView.cornerRadius) == 0.0
//        expect(styledView.layer.cornerRadius) == styledView.cornerRadius
//        expect(styledView.circular) == false
//    }
//    
//    /// test that it adjusts the background color when the name is set
//    func testThatItAdjustsTheBackgroundColorWhenTheNameIsSet() {
//        view.backgroundColorName = "backgroundFill"
//        expect(self.view.backgroundColor) == UIColor(hex: 0xFAFBFB)
//    }
//    
//    /// test that it adjusts the tint color when the name is set
//    func testThatItAdjustsTheTintColorWhenTheNameIsSet() {
//        view.tintColorName = "primaryText"
//        expect(self.view.tintColor) == UIColor(hex: 0x1D1E1D)
//    }
//    
//    /// test that it adjusts the border color when the name is set
//    func testThatItAdjustsTheBorderColorWhenTheNameIsSet() {
//        view.borderColorName = "primaryText"
//        expect(UIColor(CGColor: self.view.layer.borderColor!).hexString) == "1d1e1d"
//    }
//    
//    /// test that it adjusts the layer border width when the border width is changed
//    func testThatItAdjustsTheLayerBorderWidthWhenTheBorderWidthIsChanged() {
//        view.borderWidth = 2.0
//        expect(self.view.layer.borderWidth) == 2.0
//    }
//    
//    /// test that it adjusts the layer corner radius when the corner radius is changed
//    func testThatItAdjustsTheLayerCornerRadiusWhenTheCornerRadiusIsChanged() {
//        view.cornerRadius = 4.0
//        expect(self.view.layer.cornerRadius) == 4.0
//    }
//    
//    /// test that it applies the correct corner radius on a circular view
//    func testThatItAppliesTheCorrectCornerRadiusOnACircularView() {
//        view.frame = CGRectMake(0, 0, 40.0, 20.0)
//        view.circular = true
//        expect(self.view.layer.cornerRadius) == 10.0
//    }
//    
//}
