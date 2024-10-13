//
//  Float+String.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 4/18/20.
//  Copyright © 2020 Oren Leavitt. All rights reserved.
//

import Foundation

extension Double {
    var shortString: String {
        return String(format: "%g", self)
    }
}

extension Float {
    var shortString: String {
        return String(format: "%g", self)
    }
}

extension CGFloat {
    var shortString: String {
        return String(format: "%g", self)
    }
}

extension String {
    var cgFloatValue: CGFloat {
        return Double(self).map{ CGFloat($0) } ?? 0.0
    }
    
    var intValue: Int {
        return Int(self).map{ Int($0) } ?? 0
    }
}
