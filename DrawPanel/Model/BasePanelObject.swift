//
//  BasePanelObject.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 4/18/20.
//  Copyright © 2020 Oren Leavitt. All rights reserved.
//

import Cocoa

protocol BasePanelObject {
    init(string: String)
    func toString() -> String
    func draw(dc: DrawingContext)
    var children: [BasePanelObject] { get set }
    var origin: CGPoint { get }
    var scale: CGPoint { get }
}

extension BasePanelObject {

    var scale: CGPoint {
        return CGPoint(x: 1.0, y: 1.0)
    }

    func drawCenterMark(at: CGPoint, dc: DrawingContext) {
        let path = NSBezierPath()
        path.lineWidth = dc.lineWidth
        path.move(to: CGPoint(x: (at.x - 0.05) * dc.scale * dc.dpi.width, y: at.y * dc.scale * dc.dpi.height))
        path.line(to: CGPoint(x: (at.x + 0.05) * dc.scale * dc.dpi.width, y: at.y * dc.scale * dc.dpi.height))
        path.move(to: CGPoint(x: at.x * dc.scale * dc.dpi.width, y: (at.y - 0.05) * dc.scale * dc.dpi.height))
        path.line(to: CGPoint(x: at.x * dc.scale * dc.dpi.width, y: (at.y + 0.05) * dc.scale * dc.dpi.height))
        path.stroke()
    }
}
