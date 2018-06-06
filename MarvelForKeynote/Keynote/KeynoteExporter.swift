//
//  KeynoteExporter.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 13/02/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Foundation
import ScriptingBridge
import AppKit
import ScriptingUtilities

class KeynoteExporter {

    static let temporaryDirectory = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)

    static func fileToImages(url: URL, completion: @escaping (_ urls: [URL]?, _ error: NSError?) -> Void){

        let uuid = UUID().uuidString
        let exportDirectory = temporaryDirectory.appendingPathComponent(uuid)

        let keynoteShouldCloseAfter = keynoteIsOpen() == false
        let keynoteFileShouldCloseAfter = keynoteFileIsOpen(url: url) == false

        guard let keynote = application(name: "Keynote") as? KeynoteApplication else {
            let userInfo: [String : Any] = [
                NSLocalizedFailureReasonErrorKey: "Keynote is not installed",
                NSLocalizedRecoverySuggestionErrorKey: "Please make sure you first install Keynote before using this app."
            ]

            let error = NSError(domain: "com.marvelprototyping.marvelforkeynote", code: 2500, userInfo: userInfo)
            completion(nil, error)
            return
        }

        guard let doc = keynote.open!(url) as? KeynoteDocument else {
            let userInfo: [String : Any] = [
                NSLocalizedFailureReasonErrorKey: "Your Keynote document couldn't be opened.",
                NSLocalizedRecoverySuggestionErrorKey: "Make sure your Keynote file is reachable."
            ]
            let error = NSError(domain: "com.marvelprototyping.marvelforkeynote", code: 2600, userInfo: userInfo)
            completion(nil, error)
            return
        }

        doc.exportTo!(exportDirectory, as: KeynoteExportFormat.slideImages, withProperties: [:])

        if keynoteFileShouldCloseAfter {
            doc.closeSaving!(KeynoteSaveOptions.no, savingIn: nil)
        }

        if keynoteShouldCloseAfter{
            keynote.quitSaving!(KeynoteSaveOptions.no)
        }

        if removeUUIDs(uuid, directory: exportDirectory) == false {
            completion(nil, nil)
        }

        completion(filesInDirectory(exportDirectory), nil)

    }

    // MARK: Helpers

    private static func keynoteIsOpen() -> Bool{

        let applications = NSRunningApplication.runningApplications(withBundleIdentifier: "com.apple.iWork.Keynote")

        if applications.count >= 1{
            return true
        } else {
            return false
        }

    }

    private static func keynoteFileIsOpen(url: URL) -> Bool{

        guard let keynote = application(name: "Keynote") as? KeynoteApplication else {
            return false
        }

        let matchingDocuments = keynote.documents!().contains{ (document) -> Bool in

            guard let keynoteDocument = document as? KeynoteDocument else {
                return false
            }

            return keynoteDocument.file?.lastPathComponent == url.lastPathComponent

        }

        return matchingDocuments

    }

    private static func filesInDirectory(_ directory : URL) -> [URL]?{

        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
            return fileURLs
        } catch {
            print("Error while enumerating files: \(error.localizedDescription)")
        }

        return nil

    }

    private static func removeUUIDs(_ uuid: String, directory: URL) -> Bool{

        guard let files = filesInDirectory(directory) else {
            return false
        }

        let fileManager = FileManager.default

        do {

            for file in files{
                let fileName = file.lastPathComponent
                let newFileName = fileName.replacingOccurrences(of: uuid, with: "").dropFirst()
                let newFileURL = file.deletingLastPathComponent().appendingPathComponent(String(newFileName))
                try fileManager.moveItem(at: file, to: newFileURL)
            }

        } catch {
            print("Error while changing name of files: \(error.localizedDescription)")
            return false
        }

        return true

    }

}
