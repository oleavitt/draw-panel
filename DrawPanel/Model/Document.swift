//
//  Document.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 4/18/20.
//  Copyright © 2020 Oren Leavitt. All rights reserved.
//

import Cocoa

class Document: NSDocument {

    @objc var content = Panel(contentString: "")
    var panelViewController: PanelViewController!

    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    // MARK: Enablers

//    override class var autosavesInPlace: Bool {
//        return true
//    }

    // MARK: User Interface

    override func makeWindowControllers() {
        if let windowController = PanelWindowController.create() {
            addWindowController(windowController)
            
            // Set the view controller's represented object as your document.
            if let panelVC = windowController.contentViewController as? PanelViewController {
                panelVC.representedObject = content
                panelVC.document = self
                panelViewController = panelVC
            }
        }
    }

    override func data(ofType typeName: String) throws -> Data {
        return content.data() ?? Data()
    }

    override func read(from data: Data, ofType typeName: String) throws {
        content.read(from: data)
    }
}

// MARK: Printing

extension Document {
    
    func thePrintInfo() -> NSPrintInfo {
        let thePrintInfo = NSPrintInfo()
        
        thePrintInfo.horizontalPagination = .automatic
        thePrintInfo.verticalPagination = .automatic
        thePrintInfo.isHorizontallyCentered = true
        thePrintInfo.isVerticallyCentered = true
        
        // Half inch margin all the way around.
        thePrintInfo.leftMargin = 36.0
        thePrintInfo.rightMargin = 36.0
        thePrintInfo.topMargin = 36.0
        thePrintInfo.bottomMargin = 36.0
        
        // No margins all the way around.
//        thePrintInfo.leftMargin = 0.0
//        thePrintInfo.rightMargin = 0.0
//        thePrintInfo.topMargin = 0.0
//        thePrintInfo.bottomMargin = 0.0

 //       printInfo.dictionary().setObject(NSNumber(value: true),
 //                                        forKey: NSPrintInfo.AttributeKey.headerAndFooter as NSCopying)

        return thePrintInfo
    }
    
    @objc
    func printOperationDidRun(
        _ printOperation: NSPrintOperation, success: Bool, contextInfo: UnsafeMutableRawPointer?) {
        // Printing finished...
    }
    
    @IBAction override func printDocument(_ sender: Any?) {
        super.printDocument(sender)
    }
    
    override func print(withSettings printSettings: [NSPrintInfo.AttributeKey : Any], showPrintPanel: Bool, delegate: Any?, didPrint didPrintSelector: Selector?, contextInfo: UnsafeMutableRawPointer?) {
        // Create a copy to manipulate for printing.
        printInfo = thePrintInfo()
        let pageSize = NSSize(width: printInfo.paperSize.width,
                              height: printInfo.paperSize.height)
        let panelView = PanelView()
        panelView.frame = NSRect(x: 0.0, y: 0.0, width: pageSize.width, height: pageSize.height)
        panelView.panel = content
        
        let printOperation = NSPrintOperation(view: panelView)
        printOperation.runModal(
            for: windowControllers[0].window!,
            delegate: self,
            didRun: #selector(printOperationDidRun(_:success:contextInfo:)), contextInfo: nil)
    }
}
