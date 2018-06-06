//
//  MarvelContent.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 15/03/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Foundation
import SwiftyJSON

class MarvelScreen {

    var name: String?
    var content: MarvelContent?
    var uploadUrl: String

    init(name: String? = nil, uploadUrl: String, content: MarvelContent? = nil) {

        self.name = name
        self.uploadUrl = uploadUrl

        if let content = content{
            self.content = content
        }
    }

    static func screensJsonToModel(_ json: JSON) -> [MarvelScreen]?{

        var screens = [MarvelScreen]()

        guard let screensJSON = json["edges"].array else {
            return nil
        }

        for screenJSON in screensJSON{

            if let screen = screenJsonToModel(screenJSON["node"]){
                screens.append(screen)
            }

        }

        return screens

    }

    static func screenJsonToModel(_ json: JSON) -> MarvelScreen?{

        guard let uploadUrl = json["uploadUrl"].string else {
                return nil
        }

        var content: MarvelContent?
        if let contentFound = MarvelContent.contentJsonToModel(json["content"]){
            content = contentFound
        }

        let name = json["name"].string

        return MarvelScreen(name: name, uploadUrl: uploadUrl, content: content)

    }

}
