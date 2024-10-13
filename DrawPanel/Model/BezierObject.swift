//
//  BezierObject.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 12/26/20.
//  Copyright © 2020 Oren Leavitt. All rights reserved.
//

import Foundation
import Cocoa

class BezierObject: BasePanelObject {
    var children: [BasePanelObject] = []
    var points: [CGPoint] = [CGPoint.zero]
    var thickness: CGFloat = 1
    
    static let name = "bezier"
    
    private enum BezierCompenents {
        case ptX, ptY, controlPtX, controlPtY
    }
    private enum BezierDrawState {
        case controlPt1, controlPt2, endPt
    }

    // "bezier <thickness> x0 y0 xc0 yc0 x1 y1 xc1 yc1 ...
    // example: draw a curve
    // bezier 1 -1 0 -0.5 2 1 0 0.5 -2
    required init(string: String) {
        let components = string.components(separatedBy: .whitespacesAndNewlines)
        guard components.count >= 10  else { return }
        thickness = components[1].cgFloatValue
        points = []
        let startPoint = CGPoint(x: components[2].cgFloatValue, y: components[3].cgFloatValue)
        var controlPoint1 = CGPoint(x: components[4].cgFloatValue, y: components[5].cgFloatValue)
        var controlPoint2 = CGPoint(x: components[6].cgFloatValue, y: components[7].cgFloatValue)
        var endPoint = CGPoint(x: components[8].cgFloatValue, y: components[9].cgFloatValue)
        points.append(startPoint)
        points.append(controlPoint1)
        points.append(controlPoint2)
        points.append(endPoint)
        var state: BezierCompenents = .controlPtX
        for component in components.dropFirst(10) {
            switch state {
            case .ptX:
                endPoint.x = component.cgFloatValue
                state = .ptY
            case .ptY:
                endPoint.y = component.cgFloatValue
                points.append(controlPoint1)
                points.append(controlPoint2)
                points.append(endPoint)
                state = .controlPtX
            case .controlPtX:
                controlPoint1.x = -(controlPoint2.x - endPoint.x) + endPoint.x
                controlPoint1.y = -(controlPoint2.y - endPoint.y) + endPoint.y
                controlPoint2.x = component.cgFloatValue
                state = .controlPtY
            case .controlPtY:
                controlPoint2.y = component.cgFloatValue
                state = .ptX
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
        var state: BezierDrawState = .controlPt1
        var controlPt1 = CGPoint.zero
        var controlPt2 = CGPoint.zero
        var endPt = CGPoint.zero
        for i in 1 ..< points.count {
            switch state {
            case .controlPt1:
                controlPt1 = points[i] * dc.scale * dc.dpi
                state = .controlPt2
            case .controlPt2:
                controlPt2 = points[i] * dc.scale * dc.dpi
                state = .endPt
            case .endPt:
                endPt = points[i] * dc.scale * dc.dpi
                path.curve(to: endPt, controlPoint1: controlPt1, controlPoint2: controlPt2)
                path.stroke()
                path.move(to: endPt)
                state = .controlPt1
            }
        }
    }
    
    var origin: CGPoint {
        return points[0]
    }
}
