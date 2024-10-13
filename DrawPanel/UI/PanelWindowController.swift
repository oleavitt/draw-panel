//
//  PanelWindowController.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 4/18/20.
//  Copyright © 2020 Oren Leavitt. All rights reserved.
//

import Cocoa

class PanelWindowController: NSWindowController, NSWindowDelegate {
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        /** NSWindows loaded from the storyboard will be cascaded
         based on the original frame of the window in the storyboard.
         */
        shouldCascadeWindows = true
    }
    
}
// MARK: Class Factory Methods

extension PanelWindowController {
    
    class func create() -> NSWindowController? {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Panel Window Controller")) as? NSWindowController
        return windowController
    }
}
