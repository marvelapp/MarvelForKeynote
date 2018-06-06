//
//  ViewController.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 13/02/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Cocoa
import SwiftyJSON

class SendViewController: NSViewController {

    @IBOutlet var dragView: DragView?
    @IBOutlet var deviderView: NSView?
    @IBOutlet var noFileView: NSView?
    @IBOutlet var setFileView: NSView?
    @IBOutlet var syncButton: NSButton?
    @IBOutlet var syncingView: NSView?
    @IBOutlet var projectsPopUpButton: NSPopUpButton?

    var setFileViewController: SetFileViewController?
    var syncingViewController: SyncingViewController?

    fileprivate var projects: [MarvelProject]?{
        didSet{

            guard let projects = projects else {
                return
            }

            let selectedProject = self.selectedProject()

            projectsPopUpButton?.removeAllItems()

            // Don't use addItems() here instead, because this removes duplicates...
            for project in projects{
                projectsPopUpButton?.addItem(withTitle: project.name)
            }

            if let selectedProjectName = selectedProject?.name{
                projectsPopUpButton?.selectItem(withTitle: selectedProjectName)
            }

        }
    }

    fileprivate var fileURL: URL? {
        didSet{
            updateState()
        }
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor

        dragView?.delegate = self
        projectsPopUpButton?.menu?.delegate = self

        deviderView?.wantsLayer = true
        deviderView?.layer?.backgroundColor = NSColor("#E0E6ED")?.cgColor ?? NSColor.black.cgColor

        updateState()
        updateProjects()

    }

    // MARK: Methods

    func updateState(){

        if fileURL == nil || projects?.count == 0{
            noFileView?.isHidden = false
            setFileView?.isHidden = true
            syncButton?.isEnabled = false
        } else {
            noFileView?.isHidden = true
            setFileView?.isHidden = false
            syncButton?.isEnabled = true
        }

        setFileViewController?.titleTextField?.stringValue = fileURL?.deletingPathExtension().lastPathComponent ?? ""

    }

    func updateProjects(){

        guard let accessToken = AuthenticationManager.shared.token()?.accessToken else {
            Alert(title: "No access token. Please sign in again...", subtitle: "If the problem persists contact help@marvelapp.com").show()
            return
        }

        Calls().projectsIncludingCompany(accessToken: accessToken) { (json, response, error) in

            if error != nil{
                // Handle erroring
                return
            }

            guard let json = json else {
                // Handle erroring
                return
            }

            guard let projects = MarvelProject.projectsJsonToModel(json) else{
                return
            }

            DispatchQueue.main.async{

                self.projects = projects

            }

        }

    }

    // MARK: Segue

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {

        switch segue.destinationController {

            case let noFileViewController as NoFileViewController:
                noFileViewController.delegate = self

            case let setFileViewController as SetFileViewController:
                setFileViewController.delegate = self
                self.setFileViewController = setFileViewController

            case let syncingViewController as SyncingViewController:
                syncingViewController.delegate = self
                self.syncingViewController = syncingViewController

            default:
                return

        }

    }

    // MARK: Actions

    @IBAction func sync(button: NSButton){

        self.syncingView?.isHidden = false

        guard let fileURL = self.fileURL else {
            return
        }

        guard let project = selectedProject() else {
            return
        }

        syncingViewController?.uploadFile(fileURL: fileURL, project: project)

    }

}

extension SendViewController: NSMenuDelegate {

    func menuWillOpen(_ menu: NSMenu) {

        updateProjects()

    }

    func selectedProject() -> MarvelProject?{

        guard let projectName = projectsPopUpButton?.selectedItem?.title else {
            return nil
        }

        let project = projects?.filter({ (project) -> Bool in
            project.name == projectName
        }).first

        return project

    }

}

extension SendViewController: NSUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }

    func showFinishedNotification() {
        let notification = NSUserNotification()
        notification.title = "Finished uploading your slides 😍"
        notification.informativeText = "Your slides should now be visible inside Marvel."
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.delegate = self
        NSUserNotificationCenter.default.deliver(notification)
    }

}

extension SendViewController: SyncingViewDelegate {

    func cancelled() {
        self.syncingView?.isHidden = true
    }

    func finished() {
        self.syncingView?.isHidden = true
        showFinishedNotification()
    }

}

extension SendViewController: DragViewDelegate {
    
    func draggedFile(fileURL: URL) {
        self.fileURL = fileURL
    }

}

extension SendViewController: NoFileViewDelegate {

    func pickedFile(fileURL: URL) {
        self.fileURL = fileURL
    }

}

extension SendViewController: SetFileViewDelegate {

    func removedFile() {
        fileURL = nil
    }

}
