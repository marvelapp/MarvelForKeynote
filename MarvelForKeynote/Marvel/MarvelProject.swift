//
//  Marvel.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 05/03/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Foundation
import SwiftyJSON

class MarvelProject {

    // Non optionals
    var name = ""
    var pk = 0
    var lastModified = Date()

    // Optionals
    var screens: [MarvelScreen]?

    init(pk: Int, name: String, lastModified: Date, screens: [MarvelScreen]? = nil) {
        self.pk = pk
        self.name = name
        self.screens = screens
        self.lastModified = lastModified
    }

    static func projectJsonToModel(_ json: JSON) -> MarvelProject?{

        guard
            let pk = json["pk"].int,
            let name = json["name"].string,
            let dateString = json["lastModified"].string else {
                return nil
        }

        guard let lastModified = MarvelProject.dateFromString(dateString) else {
            return nil
        }

        let screens = MarvelScreen.screensJsonToModel(json["screens"])

        return MarvelProject(pk: pk, name: name, lastModified: lastModified, screens: screens)

    }

    static func dateFromString(_ dateAsString: String?) -> Date? {
        guard let string = dateAsString else { return nil }

        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let val = dateformatter.date(from: string)
        return val
    }

    static func projectsJsonToModel(_ json: JSON) -> [MarvelProject]?{

        var projects = [MarvelProject]()

        guard var projectsJSON = json["data"]["user"]["projects"]["edges"].array else {
            return nil
        }

        // Check if users has company projects
        if let companyProjectsArray = json["data"]["user"]["company"]["projects"]["edges"].array {
            projectsJSON.append(contentsOf: companyProjectsArray)
        }

        for projectJSON in projectsJSON{

            if let project = projectJsonToModel(projectJSON["node"]){
                projects.append(project)
            }

        }

        // Clear duplicates as company projects might include personal projects...
        let filteredProjects = projects.filterDuplicates {
            $0.pk == $1.pk
        }

        let sortedProjects = filteredProjects.sorted { (project1, project2) -> Bool in
            project1.lastModified > project2.lastModified
        }

        return sortedProjects

    }

}

