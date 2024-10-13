//
//  CustomObject.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 9/12/21.
//  Copyright © 2021 Oren Leavitt. All rights reserved.
//

import Foundation
import Cocoa

// This will be an instance of a named group rendered at a given location
class CustomObject: BasePanelObject {
    var children: [BasePanelObject] = []
    var origin: CGPoint = CGPoint.zero

    // <name> x y
    required init(string: String) {
        // TODO: Read name from string and look for it in custom objects dictionary
        // Read the x y postion
    }

    func toString() -> String {
        // TODO: Write out custom object's name and origin
        return ""
    }

    func draw(dc: DrawingContext) {
        // TODO: Get the stored object list for this name and draw them, offset by x y
    }
}
