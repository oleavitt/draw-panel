//
//  PanelObject.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 7/19/20.
//  Copyright © 2020 Oren Leavitt. All rights reserved.
//

import Foundation
import Cocoa

class PanelObject: BasePanelObject {
    var children: [BasePanelObject] = []
    
    static let name = "panel"
    var rect: CGRect = CGRect.zero
    
    // panel x y width height
    // panel 0 0 2 9
    required init(string: String) {
        let components = string.components(separatedBy: .whitespacesAndNewlines)
        if components.count == 5 {
            rect = CGRect(x: components[1].cgFloatValue,
                          y: components[2].cgFloatValue,
                          width: components[3].cgFloatValue,
                          height: components[4].cgFloatValue)
        }
    }
    
    var origin: CGPoint {
        return rect.origin
    }
    
    func toString() -> String {
        return "\(Self.name) \(rect.origin.x.shortString) \(rect.origin.y.shortString) \(rect.width.shortString) \(rect.height.shortString)"
    }
    
    func draw(dc: DrawingContext) {
        let path: NSBezierPath = NSBezierPath.init(rect: rect * dc.scale * dc.dpi)
        path.lineWidth = dc.lineWidth
        path.stroke()
    }
}
