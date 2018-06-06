//
//  Data.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 16/03/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Foundation

extension Data {

    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }

}
