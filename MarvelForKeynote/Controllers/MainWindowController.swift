//
//  MainWindowController.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 15/02/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Cocoa
import MarvelAuth

class MainWindowController: NSWindowController {

    @IBOutlet var settingsButton: NSButton?

    override func windowDidLoad() {
        super.windowDidLoad()

        var frame = window?.frame
        frame?.size = NSSize(width: 295, height:423)
        window?.setFrame(frame!, display: true)
        window?.backgroundColor = NSColor.white

        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
        window?.styleMask.insert(NSWindow.StyleMask.fullSizeContentView)

        let authManager = AuthenticationManager.shared
        authManager.delegate = self

        if authManager.token() != nil{
            setSendViewController()
        } else {
            setConnectViewController()
        }

    }

    // MARK: Actions

    @IBAction func settings(button: NSButton) {

        let menu = NSMenu()
        let logoutItem = NSMenuItem(title: "Sign out", action: #selector(self.logout), keyEquivalent: "")
        menu.addItem(logoutItem)

        let point = NSPoint(x: button.frame.maxX - 20, y: button.frame.minY)
        menu.popUp(positioning: nil, at: point, in: button.superview)

    }

    @objc func logout(){
        AuthenticationManager.shared.deleteToken()
        setConnectViewController()
    }


    // MARK: ViewControllers

    func setConnectViewController(){

        guard let connectViewController = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "connectViewController")) as? ConnectViewController else {
            return
        }

        settingsButton?.isHidden = true
        contentViewController = connectViewController

    }

    func setSendViewController(){

        guard let sendViewController = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "sendViewController")) as? SendViewController else {
            return
        }

        settingsButton?.isHidden = false
        contentViewController = sendViewController

    }

}


extension MainWindowController: AuthenticationManagerDelegate {

    func didLogin() {

        DispatchQueue.main.async {
            self.setSendViewController()
        }

    }

    func tokenExpired() {

        DispatchQueue.main.async {
            self.setConnectViewController()
        }

    }

}
