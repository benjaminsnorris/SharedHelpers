//
//  GradientViewSpec.swift
//  align
//
//  Created by Ben Norris on 5/26/16.
//  Copyright © 2016 OC Tanner. All rights reserved.
//

//import UIKit
//import Quick
//import Nimble
//@testable import align
//
//class GradientViewSpec: QuickSpec {
//    
//    override func spec() {
//        
//        describe("GradientView") {
//            
//            var gradientView: GradientView!
//            
//            beforeEach {
//                gradientView = GradientView(frame: .zero)
//            }
//            
//            it("should initialize with proper default values") {
//                expect(gradientView.startColor) == UIColor.blueColor()
//                expect(gradientView.endColor) == UIColor.redColor()
//                expect(gradientView.direction) == 0
//                expect(gradientView.computedDirection == .Vertical) == true
//            }
//            
//            it("should change direction properly") {
//                gradientView.direction = 1
//                gradientView.layoutSubviews()
//                expect(gradientView.computedDirection == .Horizontal) == true
//                
//                gradientView.direction = 2
//                gradientView.layoutSubviews()
//                expect(gradientView.computedDirection == .DiagonalDown) == true
//                
//                gradientView.direction = 3
//                gradientView.layoutSubviews()
//                expect(gradientView.computedDirection == .DiagonalUp) == true
//            }
//            
//            it("should not cause an error to give an invalid direction") {
//                gradientView.direction = 5
//                gradientView.layoutIfNeeded()
//                expect(gradientView.computedDirection == .Vertical) == true
//            }
//            
//        }
//        
//    }
//    
//}
