//
//  Button.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 05/03/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//  Based on: https://github.com/OskarGroth/FlatButton

import Cocoa
import QuartzCore

open class Button: NSButton, CALayerDelegate {

    enum Style: Int {
        case blue
        case link
    }

    internal var containerLayer = CALayer()
    internal var titleLayer = CATextLayer()
    internal var mouseDown = Bool()
    internal var style: Style = .blue {
        didSet{
            setState()
        }
    }

    @IBInspectable var underlineFrom:Int = 0 {
        didSet {
            setState()
        }
    }

    @IBInspectable var underlineLength:Int = 0 {
        didSet {
            setState()
        }
    }

    @IBInspectable var styleAdapter:Int {
        get {
            return self.style.rawValue
        }
        set(styleIndex) {
            self.style = Style(rawValue: styleIndex) ?? .blue
        }
    }


    public var momentary: Bool = true {
        didSet {
            setState()
        }
    }

    override open var title: String {
        didSet {
            setState()
        }
    }
    override open var font: NSFont? {
        didSet {
            setState()
        }
    }
    override open var frame: NSRect {
        didSet {
            positionTitle()
        }
    }
    override open var isEnabled: Bool {
        didSet {
            if isEnabled {
                setState()
            } else {
                setState(disabled: true)
            }
        }
    }

    // MARK: Setup & Initialization

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override init(frame: NSRect) {
        super.init(frame: frame)
        setup()
    }

    internal func setup() {
        wantsLayer = true
        containerLayer.masksToBounds = true
        containerLayer.cornerRadius = 4
        layer?.delegate = self
        titleLayer.delegate = self
        if let scale = window?.backingScaleFactor {
            titleLayer.contentsScale = scale
        }
        containerLayer.shadowOffset = NSSize.zero
        containerLayer.shadowColor = NSColor.clear.cgColor
        containerLayer.frame = NSMakeRect(0, 0, bounds.width, bounds.height)
        containerLayer.addSublayer(titleLayer)
        layer?.addSublayer(containerLayer)
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        let trackingArea = NSTrackingArea(rect: bounds, options: [.activeAlways, .inVisibleRect, .mouseEnteredAndExited], owner: self, userInfo: nil)
        addTrackingArea(trackingArea)
    }

    // MARK: Interaction

    public func setState(disabled: Bool? = false){

        // Disabled

        if let disabled = disabled, disabled == true{

            let disabledColor = NSColor("#F9FAFC") ?? NSColor.gray
            let disabledBorderColor = NSColor("#D3DCE6") ?? NSColor.darkGray
            let textColor = NSColor("#8392A7") ?? NSColor.darkGray
            let font = NSFont.systemFont(ofSize: 13)

            containerLayer.backgroundColor = disabledColor.cgColor
            containerLayer.borderColor = disabledBorderColor.cgColor
            containerLayer.borderWidth = 1
            attributeTitle(font: font, color: textColor.cgColor)
            positionTitle()

            return
        }

        // Defaults
        var color = NSColor.gray
        var colorPressed = NSColor.darkGray
        var textColor = NSColor.white
        var textColorPressed = NSColor.white
        var borderColor = NSColor.darkGray
        var borderColorPressed = NSColor.black
        var borderWidth: CGFloat = 1
        var borderWidthPressed: CGFloat = 1
        var font = NSFont.systemFont(ofSize: 12)

        switch style {
            case .blue:
                color = NSColor("#1FB6FF") ?? NSColor.blue
                colorPressed = NSColor("#009EEB") ?? NSColor.blue
                textColor = NSColor.white
                textColorPressed = NSColor.white
                borderColor = NSColor.clear
                borderColorPressed = NSColor.clear
                borderWidth = 0
                borderWidthPressed = 0
                font = NSFont.systemFont(ofSize: 13)
            case .link:
                color = NSColor.clear
                colorPressed = NSColor.clear
                textColor = NSColor("#8492A6") ?? NSColor.blue
                textColorPressed = NSColor("#3E4854") ?? NSColor.blue
                borderColor = NSColor.clear
                borderColorPressed = NSColor.clear
                borderWidth = 0
                borderWidthPressed = 0
                font = NSFont.systemFont(ofSize: 12)
        }

        containerLayer.backgroundColor = mouseDown ? colorPressed.cgColor : color.cgColor
        containerLayer.borderWidth = mouseDown ? borderWidthPressed : borderWidth
        containerLayer.borderColor = mouseDown ? borderColorPressed.cgColor : borderColor.cgColor

        let stateTitleColor = mouseDown ? textColorPressed.cgColor : textColor.cgColor
        attributeTitle(font: font, color: stateTitleColor)

        positionTitle()

    }

    func attributeTitle(font: NSFont, color: CGColor){

        let stringAttributed = NSMutableAttributedString.init(string: self.title)
        stringAttributed.addAttribute(NSAttributedStringKey.underlineStyle, value:NSUnderlineStyle.styleSingle.rawValue, range: NSRange.init(location: underlineFrom, length: underlineLength))
        stringAttributed.addAttribute(NSAttributedStringKey.font, value:font, range: NSRange.init(location: 0, length: stringAttributed.length))
        stringAttributed.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: NSRange.init(location: 0, length: stringAttributed.length))
        titleLayer.string = stringAttributed

    }

    func positionTitle() {

        guard let attributedString = titleLayer.string as? NSAttributedString else {
            return
        }

        var range : NSRange? = NSMakeRange(0, title.count)

        let attributes = attributedString.attributes(at: 0, effectiveRange: &range!)

        let titleSize = title.size(withAttributes: attributes)
        var titleRect = NSMakeRect(0, 0, titleSize.width, titleSize.height)
        titleRect.origin.y = round((bounds.height - titleSize.height)/2)
        titleRect.origin.x = round((bounds.width - titleSize.width)/2)
        titleLayer.frame = titleRect
    }


    override open func hitTest(_ point: NSPoint) -> NSView? {
        return isEnabled ? super.hitTest(point) : nil
    }

    override open func mouseDown(with event: NSEvent) {
        if isEnabled {
            mouseDown = true
            setState()
        }
    }

    override open func mouseEntered(with event: NSEvent) {
        if mouseDown {
            setState()
        }
    }

    override open func mouseExited(with event: NSEvent) {
        if mouseDown {
            mouseDown = false
            setState()
        }
    }

    override open func mouseUp(with event: NSEvent) {
        if mouseDown {
            mouseDown = false
            if momentary {
                setState()
            }
            _ = target?.perform(action, with: self)
        }
    }

    // MARK: Drawing

    override open func viewDidChangeBackingProperties() {
        super.viewDidChangeBackingProperties()
        if let scale = window?.backingScaleFactor {
            titleLayer.contentsScale = scale
            layer?.contentsScale = scale
        }
    }

    override open func layer(_ layer: CALayer, shouldInheritContentsScale newScale: CGFloat, from window: NSWindow) -> Bool {
        return true
    }

    override open func draw(_ dirtyRect: NSRect) {
        // Needed
    }

    override open func layout() {
        super.layout()
        positionTitle()
    }

    override open func updateLayer() {
        super.updateLayer()
    }


}

