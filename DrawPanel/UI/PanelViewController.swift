//
//  PanelViewController.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 4/18/20.
//  Copyright © 2020 Oren Leavitt. All rights reserved.
//

import Cocoa

// MARK: PanelViewController

class PanelViewController: NSViewController {

    @IBOutlet weak var panelView: PanelView!
    @IBOutlet weak var textView: NSTextView!
    weak var document: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
            // Pass down the represented object to all of the child view controllers.
            for child in children {
                child.representedObject = representedObject
            }
            
            if let panel = panel {
                print("Number of items in panel: \(panel.drawingObjects.count)")
                for object in panel.drawingObjects {
                    print("    \(object.toString())")
                }
                panelView.panel = panel
            }
        }
    }

    weak var panel: Panel? {
        if let docRepresentedObject = representedObject as? Panel {
            return docRepresentedObject
        }
        return nil
    }
}

// MARK: NSTextViewDelegate

extension PanelViewController: NSTextViewDelegate {

    func textDidChange(_ notification: Notification) {
        panel?.update(contentString: textView.string)
        panelView.needsDisplay = true
    }
    
    func textDidBeginEditing(_ notification: Notification) {
        print("Begin edit")
        document?.objectDidBeginEditing(self)
    }

    func textDidEndEditing(_ notification: Notification) {
        print("End edit")
        document?.objectDidEndEditing(self)
    }
}
