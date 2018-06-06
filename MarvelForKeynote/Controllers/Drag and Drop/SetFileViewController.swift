//
//  SetFileViewController.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 05/03/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Cocoa

protocol SetFileViewDelegate {
    func removedFile()
}

class SetFileViewController: NSViewController {

    @IBOutlet var titleTextField: NSTextField?
    @IBOutlet var removeFileButton: Button?

    var delegate: SetFileViewDelegate?

    @IBAction func remove(button: NSButton){
        delegate?.removedFile()
    }

}
