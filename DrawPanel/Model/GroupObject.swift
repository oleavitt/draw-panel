//
//  GroupObject.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 7/24/20.
//  Copyright © 2020 Oren Leavitt. All rights reserved.
//

import Foundation
import Cocoa

class GroupObject: BasePanelObject {
    var children: [BasePanelObject] = []
    
    static let name = "group"
    var origin: CGPoint = CGPoint.zero
    var scale: CGPoint = CGPoint(x: 1.0, y: 1.0)
    
    // group x y scale
    //      child objects relative to x y
    required init(string: String) {
        let components = string.components(separatedBy: .whitespacesAndNewlines)
        guard components.count >= 3 else { return }
        origin = CGPoint(x: components[1].cgFloatValue,
                         y: components[2].cgFloatValue)
        if components.count >= 4 {
            scale.x = components[3].cgFloatValue
            if components.count >= 5 {
                scale.y = components[4].cgFloatValue
            } else {
                scale.y = scale.x
            }
        }
    }
    
    
    func toString() -> String {
        return "\(Self.name) \(origin.x.shortString) \(origin.y.shortString) \(scale.x.shortString) \(scale.y.shortString)"
    }
    
    func draw(dc: DrawingContext) {
        // No op
    }
}
