//
//  DialObject.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 7/23/20.
//  Copyright © 2020 Oren Leavitt. All rights reserved.
//

import Foundation
import Cocoa

class DialObject: BasePanelObject {
    var children: [BasePanelObject] = []
    
    static let name = "dial"
    var center = CGPoint.zero
    var diameter: CGFloat = 0.0
    var sections = 10
    var startAngle: CGFloat = -135
    var degrees: CGFloat = 270
    
    var majorTickWidth: CGFloat = 3
    var majorTickLength: CGFloat = 0.150
    var minorTickWidth: CGFloat = 1
    var minorTickLength: CGFloat = 0.075
    
    // dial 1 1.5 1 10 -135 270
    // dial x y diameter number-of-steps startAngle degrees
    required init(string: String) {
        let components = string.components(separatedBy: .whitespacesAndNewlines)
        if components.count >= 4 {
            center = CGPoint(x: components[1].cgFloatValue, y: components[2].cgFloatValue)
            diameter = components[3].cgFloatValue
            if components.count >= 5 {
                sections = components[4].intValue
                if components.count >= 6 {
                    startAngle = components[5].cgFloatValue
                    if components.count >= 7 {
                        degrees = components[6].cgFloatValue
                        if components.count >= 8 {
                            majorTickLength = components[7].cgFloatValue
                            if components.count >= 9 {
                                minorTickLength = components[8].cgFloatValue
                            }
                        }
                    }
               }
            }
        }
    }
    
    func toString() -> String {
        return "\(Self.name) \(center.x.shortString) \(center.y.shortString) \(diameter.shortString) \(CGFloat(sections).shortString) \(startAngle.shortString) \(degrees.shortString) \(majorTickLength.shortString) \(minorTickLength.shortString)"
    }
    
    func draw(dc: DrawingContext) {
        let numTicks = sections * 2
        let step = (degrees * .pi / 180) / CGFloat(numTicks)
        let startAngleRadians = startAngle * .pi / 180
        var theta = startAngleRadians
        let innerRadius = diameter / 2
        let midRadius = innerRadius + minorTickLength
        let outerRadius = innerRadius + majorTickLength
        for i in 0 ... numTicks {
            let path: NSBezierPath = NSBezierPath()
            var endRadius = outerRadius
            if i & 1 == 0 {
                path.lineWidth = dc.lineWidth * majorTickWidth
            } else {
                path.lineWidth = dc.lineWidth * minorTickWidth
                endRadius = midRadius
            }
            let startPoint = CGPoint(x: sin(theta) * innerRadius + center.x, y: cos(theta) * innerRadius + center.y) * dc.scale * dc.dpi
            let endPoint = CGPoint(x: sin(theta) * endRadius + center.x, y: cos(theta) * endRadius + center.y) * dc.scale * dc.dpi
            path.move(to: startPoint)
            path.line(to: endPoint)
            path.stroke()
            theta += step
        }
    }
    
    var origin: CGPoint {
        return center
    }
}
