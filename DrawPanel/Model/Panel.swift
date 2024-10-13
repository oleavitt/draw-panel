//
//  Panel.swift
//  DrawPanel
//
//  Created by Oren Leavitt on 4/18/20.
//  Copyright © 2020 Oren Leavitt. All rights reserved.
//

import Cocoa

class Panel: NSObject {
    @objc dynamic var contentString = ""
    var drawingObjects: [BasePanelObject] = []

    public init(contentString: String) {
        self.contentString = contentString
    }
}

// MARK: Serialization

extension Panel {

    func update(contentString: String) {
        self.contentString = contentString
        parseDrawingObjects()
    }
    
    func read(from data: Data) {
        if let string = String(bytes: data, encoding: .utf8) {
            update(contentString: string)
        }
    }

    func data() -> Data? {
        serializeDrawingObjects()
        return contentString.data(using: .utf8)
    }
}

// MARK: Private

private extension Panel {

    func parseDrawingObjects() {
        let objectStrings = contentString.components(separatedBy: .newlines)
        drawingObjects = buildObjectList(from: objectStrings)
    }

    func buildObjectList(from objectStrings: [String]) -> [BasePanelObject] {
        var objectList: [BasePanelObject] = []
        var object: BasePanelObject?
        var childObjectBlock: [String] = []
        
        for var objectString in objectStrings {
            if objectString.first == "\t" {
                objectString.removeFirst()
                childObjectBlock.append(objectString)
                continue
            }
            
            if !childObjectBlock.isEmpty {
                if var parentObject = object {
                    debugPrint("Adding child list of \(childObjectBlock.count) object(s) to last to '\(parentObject.toString())'")
                    parentObject.children = buildObjectList(from: childObjectBlock)
                } else {
                    debugPrint("Child list of \(childObjectBlock.count) object(s) with no parent. Just add to current list")
                    objectList += buildObjectList(from: childObjectBlock)
                }
                childObjectBlock = []
            }
            
            object = nil
            objectString = objectString.trimmingCharacters(in: .whitespaces)
            if let name = objectString.components(separatedBy: .whitespaces).first {
                switch name {
                case GroupObject.name:
                    object = GroupObject.init(string: objectString)
                case PanelObject.name:
                    object = PanelObject.init(string: objectString)
                case RoundHoleObject.name:
                    object = RoundHoleObject.init(string: objectString)
                case TextObject.name:
                    object = TextObject(string: objectString)
                case DialObject.name:
                    object = DialObject(string: objectString)
                case LineObject.name:
                    object = LineObject(string: objectString)
                case BezierObject.name:
                    object = BezierObject(string: objectString)
                default:
                    debugPrint("Unknown object string: \(objectString)")
                    break
                }
                
                if let object = object {
                    debugPrint("Created object: \(object.toString())")
                    objectList.append(object)
                }
            }
        }
        
        // TODO: Refactor this duplicate code!
        // For now, this ensures the child list is added to parent if last item in child list is end of content string.
        if !childObjectBlock.isEmpty {
            if var parentObject = object {
                debugPrint("Adding child list of \(childObjectBlock.count) object(s) to last to '\(parentObject.toString())'")
                parentObject.children = buildObjectList(from: childObjectBlock)
            } else {
                debugPrint("Child list of \(childObjectBlock.count) object(s) with no parent. Just add to current list")
                objectList += buildObjectList(from: childObjectBlock)
            }
            childObjectBlock = []
        }
        
        return objectList
    }

    func serializeDrawingObjects() {
        //contentString = serializeObjects(drawingObjects, level: 0)
    }
    
//    func serializeObjects(_ objectList: [BasePanelObject], level: Int) -> String {
//        var objectBlockString: String = ""
//        for object in objectList {
//            var tabLevel = level
//            while tabLevel > 0 {
//                objectBlockString += "\t"
//                tabLevel -= 1
//            }
//            objectBlockString += object.toString() + "\n"
//            objectBlockString += serializeObjects(object.children, level: level + 1)
//        }
//
//        return objectBlockString
//    }
}
