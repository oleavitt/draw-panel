//
//  CGPoint+Ext.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 4/20/20.
//  Copyright © 2020 Oren Leavitt. All rights reserved.
//

import Foundation

extension CGPoint {

    static func * (left: Self, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: left.x * scalar, y: left.y * scalar)
    }
    static func *= (left: inout CGPoint, scalar: CGFloat) {
        left = left * scalar
    }
    
    static func * (left: Self, size: CGSize) -> CGPoint {
        return CGPoint(x: left.x * size.width, y: left.y * size.height)
    }
    static func *= (left: inout CGPoint, size: CGSize) {
        left = left * size
    }
    
    static func / (left: Self, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: left.x / scalar, y: left.y / scalar)
    }
    static func /= (left: inout CGPoint, scalar: CGFloat) {
        left = left / scalar
    }
}
