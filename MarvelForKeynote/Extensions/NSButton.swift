//
//  NSButton.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 05/03/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Cocoa

extension NSButton {
    var isAttributed: Bool {
        let attributedString = attributedStringValue
        let range = NSMakeRange(0, attributedString.length)
        var allAttributes = [Dictionary<NSAttributedStringKey, Any>]()
        attributedString.enumerateAttributes(in: range, options: []) { attributes, _, _ in
            allAttributes.append(attributes)
        }
        return allAttributes.count > 1
    }
}
