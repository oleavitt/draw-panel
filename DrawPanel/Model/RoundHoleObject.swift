//
//  RoundHoleObject.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 7/20/20.
//  Copyright © 2020 Oren Leavitt. All rights reserved.
//

import Foundation
import Cocoa

class RoundHoleObject: BasePanelObject {
    var children: [BasePanelObject] = []
    
    static let name = "hole"
    var center = CGPoint.zero
    var diameter: CGFloat = 0.0
    private var rect = CGRect.zero
    
    // hole x y diameter
    // hole 0.5 3.5 0.25
    required init(string: String) {
        let components = string.components(separatedBy: .whitespacesAndNewlines)
        if components.count == 4 {
            center = CGPoint(x: components[1].cgFloatValue, y: components[2].cgFloatValue)
            diameter = components[3].cgFloatValue
            rect = CGRect(x: center.x - (diameter * 0.5),
                          y: center.y - (diameter * 0.5),
                          width: diameter,
                          height: diameter)
        }
    }
    
    var origin: CGPoint {
        return center
    }
    
    func toString() -> String {
        return "\(Self.name) \(center.x.shortString) \(center.y.shortString) \(diameter.shortString)"
    }
    
    func draw(dc: DrawingContext) {
        let path: NSBezierPath = NSBezierPath.init(ovalIn: rect * dc.scale * dc.dpi)
        path.lineWidth = dc.lineWidth
        path.stroke()
        drawCenterMark(at: center, dc: dc)
    }
}

