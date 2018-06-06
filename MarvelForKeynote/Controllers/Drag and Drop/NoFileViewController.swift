//
//  NoFileViewController.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 05/03/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Cocoa

protocol NoFileViewDelegate {
    func pickedFile(fileURL: URL)
}

class NoFileViewController: NSViewController {

    var delegate: NoFileViewDelegate?

    @IBAction func browseFile(button: NSButton) {

        let dialog = NSOpenPanel();

        dialog.title = "Choose a .key file";
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.canChooseDirectories = false
        dialog.canCreateDirectories = false
        dialog.allowsMultipleSelection = false
        dialog.allowedFileTypes = ["key"];

        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url
            if let fileURL = result {
                self.delegate?.pickedFile(fileURL: fileURL)
            }
        }

    }

}
