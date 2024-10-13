//
//  LineObject.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 12/26/20.
//  Copyright © 2020 Oren Leavitt. All rights reserved.
//

import Foundation
import Cocoa

class LineObject: BasePanelObject {
    var children: [BasePanelObject] = []
    var points: [CGPoint] = [CGPoint.zero]
    var thickness: CGFloat = 1

    static let name = "line"
    
    // "line <thickness> x0 y0 ... xn yn
    // example: draw a triangle
    // line 1 -1 -1 0 1 1 -1 -1 -1
    required init(string: String) {
        let components = string.components(separatedBy: .whitespacesAndNewlines)
        guard components.count >= 4  else { return }
        thickness = components[1].cgFloatValue
        points = []
        var expectY = false
        var point = CGPoint.zero
        for component in components.dropFirst(2) {
            if expectY {
                point.y = component.cgFloatValue
                points.append(point)
                expectY = false
            } else {
                point.x = component.cgFloatValue
                expectY = true
            }
        }
    }
    
    func toString() -> String {
        var string = "\(Self.name) \(thickness.shortString)"
        for point in points {
            string.append(" \(point.x.shortString) \(point.y.shortString)")
        }
        return string
    }
    
    func draw(dc: DrawingContext) {
        guard points.count > 1 else { return }
        let path: NSBezierPath = NSBezierPath()
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.lineWidth = dc.lineWidth * thickness
        path.move(to: points[0] * dc.scale * dc.dpi)
        for i in 1 ..< points.count {
            path.line(to: points[i] * dc.scale * dc.dpi)
        }
        path.stroke()
    }
    
    var origin: CGPoint {
        return points[0]
    }
}
