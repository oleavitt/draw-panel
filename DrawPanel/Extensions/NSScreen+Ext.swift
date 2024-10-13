//
//  NSScreen+Ext.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 4/20/20.
//  Copyright © 2020 Oren Leavitt. All rights reserved.
//

import Cocoa

public extension NSScreen {
    var unitsPerInch: CGSize {
        let millimetersPerInch:CGFloat = 25.4
        let screenDescription = deviceDescription
        if let displayUnitSize = (screenDescription[NSDeviceDescriptionKey.size] as? NSValue)?.sizeValue,
            let screenNumber = (screenDescription[NSDeviceDescriptionKey("NSScreenNumber")] as? NSNumber)?.uint32Value {
            let displayPhysicalSize = CGDisplayScreenSize(screenNumber)
            return CGSize(width: millimetersPerInch * displayUnitSize.width / displayPhysicalSize.width,
                          height: millimetersPerInch * displayUnitSize.height / displayPhysicalSize.height)
        } else {
            return CGSize(width: 72.0, height: 72.0) // this is the same as what CoreGraphics assumes if no EDID data is available from the display device — https://developer.apple.com/documentation/coregraphics/1456599-cgdisplayscreensize?language=objc
        }
    }
}
