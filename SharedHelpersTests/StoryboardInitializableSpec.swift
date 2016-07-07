//
//  StoryboardInitializableSpec.swift
//  align
//
//  Created by Ben Norris on 5/2/16.
//  Copyright © 2016 OC Tanner. All rights reserved.
//

//import UIKit
//import Quick
//import Nimble
//@testable import align
//
//class StoryboardInitializableSpec: QuickSpec {
//    
//    override func spec() {
//        
//        describe("StoryboardInitializable") {
//            
//            it("should successfully initialize a valid view controller from storyboard") {
//                expect { TestViewController.initializeFromStoryboard() }.toNot(raiseException())
//            }
//            
//            it("should fail trying to initialize a view controller not in the storyboard") {
//                expect { ProblemViewController.initializeFromStoryboard() }.to(raiseException())
//            }
//            
//            // TODO: Test for failure when possible (https://github.com/Quick/Nimble/pull/248)
////            it("should fail to initialize a view controller with the wrong identifier") {
////                expect { InvalidViewController.initializeFromStoryboard() }.to(throwAssertion())
////            }
//            
//        }
//        
//    }
//    
//}
//
//final class TestViewController: UIViewController, StoryboardInitializable {
//    static var storyboardName: String { return "TestStoryboard" }
//    static var viewControllerIdentifier: String { return String(TestViewController) }
//}
//
//final class ProblemViewController: UIViewController, StoryboardInitializable {
//    static var storyboardName: String { return "TestStoryboard" }
//    static var viewControllerIdentifier: String { return String(ProblemViewController) }
//}
//
//final class InvalidViewController: UIViewController, StoryboardInitializable {
//    static var storyboardName: String { return "TestStoryboard" }
//    static var viewControllerIdentifier: String { return String(TestViewController) }
//}
