//
//  PanelView.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 4/18/20.
//  Copyright © 2020 Oren Leavitt. All rights reserved.
//

import Cocoa

class PanelView: NSView {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        frame = CGRect(x: 0, y: 0, width: 768, height: 1024)
        translateOrigin(to: NSPoint(x: 18, y: 18))
    }
    
    @objc dynamic var panel: Panel? {
        didSet {
            needsDisplay = true
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        guard let panel = panel else { return }
        guard let gc = NSGraphicsContext.current else { return }

        let dc = DrawingContext()
        if gc.isDrawingToScreen {
            dc.dpi = NSScreen.main?.unitsPerInch ?? CGSize(width: 72, height: 72)
            dc.lineWidth = 1.0 / (NSScreen.main?.backingScaleFactor ?? 1.0)
        } else {
            dc.dpi = CGSize(width: 72, height: 72) // Scale is in inches
            dc.lineWidth = 0.5
        }
        dc.scale = 1.0
        
        gc.saveGraphicsState()
        let drawColor = NSColor(named: "draw-color") ?? NSColor.black
        drawColor.set()
        drawColor.setStroke()
        draw(objects: panel.drawingObjects, dc: dc, at: CGPoint.zero, scale: CGPoint(x: 1.0, y: 1.0))
        gc.restoreGraphicsState()
    }
    
    private func draw(objects: [BasePanelObject], dc: DrawingContext, at origin: CGPoint, scale: CGPoint) {
        guard !objects.isEmpty else { return }
        guard let gc = NSGraphicsContext.current else { return }
        
        gc.saveGraphicsState()
        let scaledOrigin = origin * dc.dpi * dc.scale
        gc.cgContext.translateBy(x: scaledOrigin.x, y: scaledOrigin.y)
        let savedScale = dc.scale
        dc.scale = scale.x
        for object in objects {
            object.draw(dc: dc)
            draw(objects: object.children, dc: dc, at: object.origin, scale: object.scale)
        }
        dc.scale = savedScale
        gc.restoreGraphicsState()
    }
}

// MARK: Printing

extension PanelView {

    override func knowsPageRange(_ range: NSRangePointer) -> Bool {
        range.pointee.location = 1
        range.pointee.length = 1
        return true
    }
    
    override func rectForPage(_ page: Int) -> NSRect {
        return bounds
    }
}

