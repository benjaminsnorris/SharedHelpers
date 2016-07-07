//
//  SegueHandlerTypeSpec.swift
//  align
//
//  Created by Ben Norris on 5/4/16.
//  Copyright © 2016 OC Tanner. All rights reserved.
//

//import UIKit
//import Quick
//import Nimble
//@testable import align
//
//class SegueHandlerTypeSpec: QuickSpec {
//    
//    override func spec() {
//        
//        describe("SegueHandlerType") {
//            
//            it("should successfully execute a segue with a valid identifier") {
//                expect {
//                    let source = SourceViewController.initializeFromStoryboard()
//                    let nav = UINavigationController(rootViewController: source)
//                    source.performSegueWithIdentifier(.TestSegue, sender: nil)
//                    let destination = nav.topViewController as? DestinationViewController
//                    expect(destination).toNot(beNil())
//                    return source
//                }.toNot(raiseException())
//            }
//            
//            it("should raise an exception when executing a segue with an invalid identifier") {
//                expect {
//                    let source = SourceViewController.initializeFromStoryboard()
//                    source.performSegueWithIdentifier(.FailingSegue, sender: nil)
//                    return source
//                }.to(raiseException())
//            }
//            
//            it("should properly return a typed identifier for a segue") {
//                let source = SourceViewController.initializeFromStoryboard()
//                let destination = DestinationViewController.initializeFromStoryboard()
//                let testSegue = UIStoryboardSegue(identifier: SourceViewController.SegueIdentifier.TestSegue.rawValue, source: source, destination: destination)
//                let testSegueIdentifier = source.segueIdentifierForSegue(testSegue)
//                expect(testSegueIdentifier) == SourceViewController.SegueIdentifier.TestSegue
//            }
//            
//            // TODO: Test for failure when possible (https://github.com/Quick/Nimble/pull/248)
////            it("should throw an assertion trying to return a typed identifier for an invalid segue") {
////                expect {
////                    let source = SourceViewController.initializeFromStoryboard()
////                    let destination = DestinationViewController.initializeFromStoryboard()
////                    let invalidSegue = UIStoryboardSegue(identifier: nil, source: source, destination: destination)
////                    let invalidSegueIdentifier = source.segueIdentifierForSegue(invalidSegue)
////                    return invalidSegueIdentifier
////                }.to(throwAssertion())
////            }
//            
//        }
//        
//    }
//    
//}
//
//final class SourceViewController: UIViewController, SegueHandlerType, StoryboardInitializable {
//    enum SegueIdentifier: String {
//        case TestSegue
//        case FailingSegue
//    }
//    static var storyboardName: String { return "TestStoryboard" }
//    static var viewControllerIdentifier: String { return String(SourceViewController) }
//}
//
//class DestinationViewController: UIViewController, StoryboardInitializable {
//    static var storyboardName: String { return "TestStoryboard" }
//    static var viewControllerIdentifier: String { return String(DestinationViewController) }
//}
