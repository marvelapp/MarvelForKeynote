//
//  NavBar.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 14/02/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Cocoa

@IBDesignable class NavBarView: NSView {

    let lineView = NSView()
    let textView = NSTextField()

    @IBInspectable var title: String = "Title" {
        didSet {
            self.textView.stringValue = title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func prepareForInterfaceBuilder() {
        setup()
    }

    func setup(){
        wantsLayer = true
        layer?.backgroundColor = NSColor("#F9FAFC")?.cgColor ?? NSColor.gray.cgColor

        lineView.wantsLayer = true
        lineView.layer?.backgroundColor = NSColor("#E5E9F2")?.cgColor ?? NSColor.gray.cgColor
        addSubview(lineView)

        textView.stringValue = title
        textView.alignment = .center
        textView.isEditable = false
        textView.isBordered = false
        textView.textColor = NSColor("#263445") ?? NSColor.black
        textView.font = NSFont.systemFont(ofSize: 12, weight: .medium)
        textView.backgroundColor = NSColor.clear
        addSubview(textView)
    }

    override func layout() {
        lineView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 1)
        textView.frame = CGRect(x: 0, y: round((frame.size.height-16)/2)+1, width: frame.size.width, height: 16)
    }
}
