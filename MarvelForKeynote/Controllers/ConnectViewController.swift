//
//  ConnectViewController.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 14/02/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Cocoa
import CoreData
import MarvelAuth

class ConnectViewController: NSViewController {


    override func viewDidLoad() {

        super.viewDidLoad()

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor

    }

    @IBAction func connect(button: Button){

        AuthenticationManager.shared.login()

    }

    @IBAction func create(button: Button){

        guard let url = URL(string: "https://marvelapp.com/signup") else{
            return
        }
        
        NSWorkspace.shared.open(url)

    }

}
