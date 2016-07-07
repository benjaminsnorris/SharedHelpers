//
//  StyledImageViewSpec.swift
//  align
//
//  Created by Ben Norris on 7/5/16.
//  Copyright © 2016 OC Tanner. All rights reserved.
//

//import XCTest
//import Nimble
//@testable import align
//
//class StyledImageViewSpec: XCTestCase {
//    
//    var imageView: StyledImageView!
//    
//    override func setUp() {
//        super.setUp()
//        imageView = StyledImageView()
//    }
//    
//    /// test that it initializes with expected values
//    func testThatItInitializesWithExpectedValues() {
//        let view = imageView
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
//    /// test that it adjusts the background color when the name is set
//    func testThatItAdjustsTheBackgroundColorWhenTheNameIsSet() {
//        imageView.backgroundColorName = "backgroundFill"
//        expect(self.imageView.backgroundColor) == UIColor(hex: 0xFAFBFB)
//    }
//    
//    /// test that it adjusts the tint color when the name is set
//    func testThatItAdjustsTheTintColorWhenTheNameIsSet() {
//        imageView.tintColorName = "primaryText"
//        expect(self.imageView.tintColor) == UIColor(hex: 0x1D1E1D)
//    }
//    
//    /// test that it adjusts the border color when the name is set
//    func testThatItAdjustsTheBorderColorWhenTheNameIsSet() {
//        imageView.borderColorName = "primaryText"
//        expect(UIColor(CGColor: self.imageView.layer.borderColor!).hexString) == "1d1e1d"
//    }
//    
//    /// test that it adjusts the layer border width when the border width is changed
//    func testThatItAdjustsTheLayerBorderWidthWhenTheBorderWidthIsChanged() {
//        imageView.borderWidth = 2.0
//        expect(self.imageView.layer.borderWidth) == 2.0
//    }
//    
//    /// test that it adjusts the layer corner radius when the corner radius is changed
//    func testThatItAdjustsTheLayerCornerRadiusWhenTheCornerRadiusIsChanged() {
//        imageView.cornerRadius = 4.0
//        expect(self.imageView.layer.cornerRadius) == 4.0
//    }
//    
//    /// test that it applies the correct corner radius on a circular view
//    func testThatItAppliesTheCorrectCornerRadiusOnACircularView() {
//        imageView.frame = CGRectMake(0, 0, 40.0, 20.0)
//        imageView.circular = true
//        expect(self.imageView.layer.cornerRadius) == 10.0
//    }
//    
//}
