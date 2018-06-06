//
//  Array.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 06/04/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Foundation

extension Array {

    func filterDuplicates(includeElement: @escaping (_ lhs: Element, _ rhs: Element) -> Bool) -> [Element] {

        var results = [Element]()

        forEach { (element) in

            let existingElements = results.filter {
                return includeElement(element, $0)
            }

            if existingElements.count == 0 {
                results.append(element)
            }
        }
        return results
    }
}
