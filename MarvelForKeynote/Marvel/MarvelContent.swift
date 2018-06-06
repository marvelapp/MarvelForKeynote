//
//  MarvelContent.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 15/03/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Foundation
import SwiftyJSON

class MarvelContent {

    // Non optionals
    var fileName = ""
    var url = ""
    var width: Int
    var height: Int

    init(fileName: String, url: String, width: Int, height: Int) {
        self.fileName = fileName
        self.url = url
        self.width = width
        self.height = height
    }

    static func contentJsonToModel(_ json: JSON) -> MarvelContent?{

        guard
            let fileName = json["filename"].string,
            let width = json["width"].int,
            let height = json["height"].int,
            let url = json["url"].string else {
                return nil
        }

        return MarvelContent(fileName: fileName, url: url, width: width, height: height)

    }

}
