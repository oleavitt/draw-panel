//
//  CGRect+Ext.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 4/20/20.
//  Copyright © 2020 Oren Leavitt. All rights reserved.
//

import Foundation

extension CGRect {
    
    static func * (left: Self, scalar: CGFloat) -> CGRect {
        return CGRect(x: left.origin.x * scalar, y: left.origin.y * scalar, width: left.width * scalar, height: left.height * scalar)
    }
    static func *= (left: inout CGRect, scalar: CGFloat) {
        left = left * scalar
    }
    
    static func * (left: Self, size: CGSize) -> CGRect {
        return CGRect(x: left.origin.x * size.width, y: left.origin.y * size.height, width: left.width * size.width, height: left.height * size.height)
    }
    static func *= (left: inout CGRect, size: CGSize) {
        left = left * size
    }
    
    static func / (left: Self, scalar: CGFloat) -> CGRect {
        return CGRect(x: left.origin.x / scalar, y: left.origin.y / scalar, width: left.width / scalar, height: left.height / scalar)
    }
    static func /= (left: inout CGRect, scalar: CGFloat) {
        left = left / scalar
    }
}
