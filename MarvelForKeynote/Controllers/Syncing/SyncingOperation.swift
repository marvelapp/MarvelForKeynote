//
//  SyncingOperation.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 16/03/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Foundation

class SyncingOperation: AsynchronousOperation {

    let fileURL: URL
    let existingScreens: [MarvelScreen]
    let project: MarvelProject
    var completionHandler: ((SyncingOperation) -> Void)?

    init(fileURL: URL, existingScreens: [MarvelScreen], project: MarvelProject) {
        self.fileURL = fileURL
        self.existingScreens = existingScreens
        self.project = project
    }

    override func start(){

        super.start()

        guard let accessToken = AuthenticationManager.shared.token()?.accessToken else {
            return
        }

        // Don't start if the item was cancelled...

        if self.isCancelled {
            finish()
            return
        }

        let fileName = fileURL.lastPathComponent

        // Check if there is already a container created to upload the Marvel image to...
        let uploadUrl = existingUploadUrlForFileName(fileName, existingScreens: existingScreens)

        if let uploadUrl = uploadUrl{

            // Existing upload url
            Calls().upload(accessToken: accessToken, url: uploadUrl, fileURL: fileURL, completion: { (json, response, error) in
                self.finish()
            })


        } else {

            // No existing upload url

            Calls().createScreen(accessToken: accessToken, projectPk: project.pk, name: fileName, completion: { (json, response, error) in

                guard let json = json else {
                    self.finish()
                    return
                }

                guard let screen = MarvelScreen.screenJsonToModel(json["data"]["createScreen"]["screen"]) else {
                    self.finish()
                    return
                }

                Calls().upload(accessToken: accessToken, url: screen.uploadUrl, fileURL: self.fileURL, completion: { (json, response, error) in
                    self.finish()
                })

            })
        }

    }

    func finish(){
        state = .finished
        completionHandler?(self)
    }

    func existingUploadUrlForFileName(_ fileName: String, existingScreens: [MarvelScreen]) -> String?{

        let matchingScreens = existingScreens.filter { (screen) -> Bool in
            return screen.content?.fileName == fileName
        }

        return matchingScreens.first?.uploadUrl

    }

}
