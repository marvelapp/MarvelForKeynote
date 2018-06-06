//
//  Dialog.swift
//  Marvel MacOS
//
//  Created by Maxime De Greve on 13/07/2016.
//  Copyright © 2016 Maxime De Greve. All rights reserved.
//

import Cocoa

class Alert {

    private let title: String
    private let subtitle: String
    private let buttonTitle: String?
    private let buttonAction: (() -> Void)?
    private let extraButtonTitle: String?
    private let extraButtonAction: (() -> Void)?


    init(title: String, subtitle: String, buttonTitle: String? = nil, buttonAction: (() -> Void)? = nil, extraButtonTitle: String? = nil, extraButtonAction: (() -> Void)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
        self.extraButtonTitle = extraButtonTitle
        self.extraButtonAction = extraButtonAction
    }

    func show() {
        let alert = NSAlert()
        alert.messageText = self.title
        alert.informativeText = self.subtitle
        alert.alertStyle = .warning
        
        if let btnTitle = self.buttonTitle {
            alert.addButton(withTitle: btnTitle)
        }
        
        if let extraBtnTitle = self.extraButtonTitle{
            alert.addButton(withTitle: extraBtnTitle)
        }

        if Thread.isMainThread {
            self.runModal(for: alert)
        } else {
            DispatchQueue.main.sync {
                self.runModal(for: alert)
            }
        }
    }

    private func runModal(for alert: NSAlert) {
        
        let result = alert.runModal()
        
        if result == .alertFirstButtonReturn {
            self.buttonAction?()
        }
        
        if result == .alertSecondButtonReturn{
            self.extraButtonAction?()
        }
        
    }

}
