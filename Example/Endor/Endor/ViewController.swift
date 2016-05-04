//
//  ViewController.swift
//  Endor
//
//  Created by Brian Partridge on 5/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = buildType.rawValue
    }

    /// Crashes in Debug builds only.
    @IBAction func assertTapped(sender: AnyObject) {
        assert(false, "Calling \(assertionTypeQualifier).assert from \(#function).")
    }
    
    /// Crashes in all builds.
    @IBAction func preconditionTapped(sender: AnyObject) {
        precondition(false, "Calling \(assertionTypeQualifier).precondition from \(#function).")
    }
    
    /// Crahes in all builds.
    @IBAction func fatalErrorTapped(sender: AnyObject) {
        fatalError("Calling \(assertionTypeQualifier).fatalError from \(#function).")
    }
    
    // MARK: - Private Methods
    
    enum BuildType: String {
        case Debug, Release
    }
    
    private var buildType: BuildType {
        #if DEBUG
            return .Debug
        #else
            return .Release
        #endif
    }
    
    private var assertionTypeQualifier: String {
        switch buildType {
        case .Debug: return "Ackbar"
        case .Release: return "Swift"
        }
    }
}

