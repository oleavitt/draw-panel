//
//  DrawingContext.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 4/19/20.
//  Copyright © 2020 Oren Leavitt. All rights reserved.
//

import Cocoa

class DrawingContext {
    var scale: CGFloat = 1.0
    var lineWidth: CGFloat = 1.0
    var parentObject: BasePanelObject?
    var dpi = NSSize(width: 1, height: 1)
}
