//
//  DropView.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 13/02/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Cocoa

protocol DragViewDelegate {
    func draggedFile(fileURL: URL)
}

class DragView: NSView {

    var delegate: DragViewDelegate?

    private var fileTypeIsOk = false
    private var acceptedFileExtensions = ["key"]

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerForDraggedTypes([NSPasteboard.PasteboardType.fileURL])
        alphaValue = 0
    }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        fileTypeIsOk = checkExtension(drag: sender)
        return []
    }

    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        return fileTypeIsOk ? .link : []
    }

    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard let draggedFileURL = sender.draggedFileURL else {
            return false
        }

        if fileTypeIsOk {
            delegate?.draggedFile(fileURL: draggedFileURL as URL)
        }

        return true
    }

    fileprivate func checkExtension(drag: NSDraggingInfo) -> Bool {
        guard let fileExtension = drag.draggedFileURL?.pathExtension?.lowercased() else {
            return false
        }

        return acceptedFileExtensions.contains(fileExtension)
    }

}

extension NSDraggingInfo {
    var draggedFileURL: NSURL? {
        let NSFilenamesPboardTypeTemp = NSPasteboard.PasteboardType("NSFilenamesPboardType")
        let filenames = draggingPasteboard().propertyList(forType: NSFilenamesPboardTypeTemp) as? [String]
        let path = filenames?.first

        return path.map(NSURL.init)
    }
}
