//
//  SyncingViewController.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 14/03/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Cocoa

protocol SyncingViewDelegate {
    func cancelled()
    func finished()
}

class SyncingViewController: NSViewController {

    @IBOutlet var animationView: NSImageView?
    @IBOutlet var titleTextField: TitleTextField?
    @IBOutlet var progressIndicator: NSProgressIndicator?

    var delegate: SyncingViewDelegate?
    var syncingOperations = SyncingOperations()

    override func viewDidLoad() {
        setupAnimation()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
    }

    @IBAction func cancel(sender: Any?){
        DispatchQueue.main.async {
            self.delegate?.cancelled()
            self.syncingOperations.cancelAllOperations()
        }
    }

    func reset(){
        self.titleTextField?.stringValue = "Exporting your slides..."
        self.progressIndicator?.doubleValue = 0
        self.progressIndicator?.maxValue = 1

        // Make sure old results don't come through anymore
        self.syncingOperations.delegate = nil

        // Setup a new queue
        syncingOperations = SyncingOperations()
        syncingOperations.delegate = self
    }

    // MARK: Animations

    func setupAnimation(){

        animationView?.wantsLayer = true

        let animation = CAKeyframeAnimation(keyPath: "contents")
        animation.calculationMode = kCAAnimationDiscrete
        animation.duration = 1.7
        animation.repeatCount = .infinity
        animation.values = (1...167).compactMap({ index in
            if let filePath = Bundle.main.pathForImageResource(NSImage.Name(rawValue: "aeroplane_\(index)")) {
                return NSImage(contentsOfFile: filePath)
            }
            return nil
        })

        self.animationView?.layer?.add(animation, forKey: "contents")

    }

    // MARK: Upload

    func uploadFile(fileURL: URL, project: MarvelProject){

        // Reset
        reset()

        // Fetch the project screens to see what we should replace
        projectScreens(projectPK: project.pk) { (screens) in

            KeynoteExporter.fileToImages(url: fileURL, completion: { (urls, error) in

                if let error = error {
                    Alert(title: error.localizedFailureReason ?? "", subtitle: error.localizedRecoverySuggestion ?? "").show()
                    self.cancel(sender: nil)
                    return
                }

                guard let urls = urls else {
                    Alert(title: "Something went wrong. Visit our Github page and submit an issue.", subtitle: "").show()
                    self.cancel(sender: nil)
                    return
                }

                for image in urls {
                    let operation = SyncingOperation(fileURL: image, existingScreens: screens, project: project)
                    self.syncingOperations.addOperation(syncingOperation: operation)
                }

            })

        }

    }

    func projectScreens(projectPK: Int, completion: @escaping ([MarvelScreen]) -> Void){

        guard let accessToken = AuthenticationManager.shared.token()?.accessToken else {
            return
        }

        Calls().project(accessToken: accessToken, pk: projectPK, completion: { (json, response, error) in

            if error != nil{
                // Handle erroring
                return
            }

            guard let json = json else {
                return
            }

            guard let project = MarvelProject.projectJsonToModel(json["data"]["project"]) else{
                return
            }

            guard let screens = project.screens else {
                return
            }

            completion(screens)

        })

    }


}

extension SyncingViewController: SyncingOperationsDelegate {

    func queueChanged() {

        DispatchQueue.main.async {

            self.titleTextField?.stringValue = "Syncing your slides..."

            let finishedSyncingCount = self.syncingOperations.finishedSyncing.count
            let syncingCount = self.syncingOperations.operationCount

            self.progressIndicator?.doubleValue = Double(finishedSyncingCount)
            self.progressIndicator?.maxValue = Double(finishedSyncingCount + syncingCount)

        }

    }

    func finished(){
        DispatchQueue.main.async {
            self.reset()
            self.delegate?.finished()
        }
    }

    func cancelled() {
        DispatchQueue.main.async {
            self.reset()
        }
    }

}

