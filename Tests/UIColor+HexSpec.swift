//
//  UIColor+HexSpec.swift
//  align
//
//  Created by Ben Norris on 5/24/16.
//  Copyright © 2016 OC Tanner. All rights reserved.
//

//import UIKit
//import Quick
//import Nimble
//@testable import align
//
//class UIColorHexSpec: QuickSpec {
//    
//    override func spec() {
//        
//        describe("UIColor+Hex") {
//            
//            it("should create colors from hex integers with full alpha") {
//                let color = UIColor(hex: 0x55aa00)
//                var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
//                let rgb = color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
//                expect(rgb) == true
//                expect(red).to(beCloseTo(0.33333))
//                expect(green).to(beCloseTo(0.66666))
//                expect(blue) == 0.0
//                expect(alpha) == 1.0
//            }
//            
//            it("should create colors from hex integers with separate alpha") {
//                let color = UIColor(hex: 0x55aa00, alpha: 0.5)
//                var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
//                let rgb = color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
//                expect(rgb) == true
//                expect(red).to(beCloseTo(0.33333))
//                expect(green).to(beCloseTo(0.66666))
//                expect(blue) == 0.0
//                expect(alpha) == 0.5
//            }
//            
//            it("should create colors from hex strings with full alpha") {
//                expect {
//                    let color = try UIColor(hexString: "55aa00")
//                    var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
//                    let rgb = color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
//                    expect(rgb) == true
//                    expect(red).to(beCloseTo(0.33333))
//                    expect(green).to(beCloseTo(0.66666))
//                    expect(blue) == 0.0
//                    return color
//                }.notTo(throwError())
//            }
//            
//            it("should create colors from hex strings with separate alpha") {
//                expect {
//                    let color = try UIColor(hexString: "55aa00", alpha: 0.5)
//                    var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
//                    let rgb = color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
//                    expect(rgb) == true
//                    expect(red).to(beCloseTo(0.33333))
//                    expect(green).to(beCloseTo(0.66666))
//                    expect(blue) == 0.0
//                    expect(alpha) == 0.5
//                    return color
//                }.notTo(throwError())
//            }
//            
//            it("should create colors from hex strings prefixed with 0x") {
//                expect {
//                    let color = try UIColor(hexString: "0x55aa00")
//                    var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
//                    let rgb = color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
//                    expect(rgb) == true
//                    expect(red).to(beCloseTo(0.33333))
//                    expect(green).to(beCloseTo(0.66666))
//                    expect(blue) == 0.0
//                    return color
//                }.notTo(throwError())
//            }
//            
//            it("should convert color to a hex string") {
//                let color = UIColor(red: 0.3333333, green: 0.6666666667, blue: 0.0, alpha: 1.0)
//                expect(color.hexString) == "55aa00"
//            }
//            
//            it("should convert a white color to a hex string") {
//                let color = UIColor(white: 0.5, alpha: 1.0)
//                expect(color.hexString) == "808080"
//            }
//            
//            it("should throw when given an invalid hex string") {
//                expect {
//                    let color = try UIColor(hexString: "not a color")
//                    return color
//                }.to(throwError())
//            }
//                        
//        }
//        
//    }
//    
//}
