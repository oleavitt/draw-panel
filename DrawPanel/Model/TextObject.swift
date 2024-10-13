//
//  TextObject.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 7/20/20.
//  Copyright © 2020 Oren Leavitt. All rights reserved.
//

import Foundation
import Cocoa

class TextObject: BasePanelObject {
    static let name = "text"
    var children: [BasePanelObject] = []
    var center = CGPoint.zero
    var text: String = ""
    var fontName: String = "Arial"
    var fontSize: CGFloat = 12
    var textColor: NSColor = .black
    
    // text x y size string
    // text 0.5 3.5 18 Signal Input
    required init(string: String) {
        let components = string.components(separatedBy: .whitespacesAndNewlines)
        if components.count >= 5 {
            center = CGPoint(x: components[1].cgFloatValue, y: components[2].cgFloatValue)
            fontSize = components[3].cgFloatValue
            text = components[4]
            for i in 5..<components.count {
                text += " \(components[i])"
            }
        }
    }
    
    var origin: CGPoint {
        return center
    }

    func toString() -> String {
        return "\(Self.name) \(center.x.shortString) \(center.y.shortString) \(fontName) \(fontSize.shortString) \(text)"
    }
    
    func draw(dc: DrawingContext) {
        guard let gc = NSGraphicsContext.current else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let adjFontSize = fontSize * dc.dpi.height / 72
        var font = NSFont(name: fontName, size: adjFontSize)
        if font == nil {
            NSLog("Could not create font from: \(fontName) - defaulting to system font.")
            font = NSFont.systemFont(ofSize: adjFontSize)
        }
        guard let validFont = font else {
            NSLog("Could not create font")
            return
        }
        let textColor = NSColor(named: "draw-color") ?? NSColor.black
        let fontAttributes: [NSAttributedString.Key : Any] = [
            .font: validFont,
            .paragraphStyle: paragraphStyle,
            .foregroundColor: textColor
        ]
        
        let size = text.size(withAttributes: fontAttributes)
        let scaledCenter = center * dc.scale * dc.dpi
        let rect = CGRect(x: scaledCenter.x - size.width / 2,
                          y: scaledCenter.y - size.height / 2, width: size.width, height: size.height)
        gc.saveGraphicsState()
        text.draw(in: rect, withAttributes: fontAttributes)
        gc.restoreGraphicsState()
    }
}
