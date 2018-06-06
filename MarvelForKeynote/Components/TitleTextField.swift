//
//  TitleTextField.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 15/02/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Cocoa

@IBDesignable class TitleTextField: NSTextField {

    override var stringValue: String {
        didSet {
            setup()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func prepareForInterfaceBuilder() {
        setup()
    }

    override func draw(_ dirtyRect: NSRect) {

        // This is very important since custom fonts get otherwise rendered really badly
        // They also would look visually fatter then they should be...
        NSGraphicsContext.current?.cgContext.setShouldSmoothFonts(false)

        super.draw(dirtyRect)

    }

    func setup(){

        let font = NSFont(name: "SFProText-Medium", size: 17) ?? NSFont.systemFont(ofSize: 17.0, weight: .medium)
        let color = NSColor("#263445") ?? NSColor.black

        let textParagraph = NSMutableParagraphStyle()
        textParagraph.lineSpacing = 8.0
        textParagraph.maximumLineHeight = 19.0
        textParagraph.alignment = alignment
        let attribs = [
            NSAttributedStringKey.font : font,
            NSAttributedStringKey.foregroundColor : color,
            NSAttributedStringKey.paragraphStyle : textParagraph
        ]
        let attrString:NSAttributedString = NSAttributedString.init(string: stringValue, attributes: attribs)
        attributedStringValue = attrString

    }

}
