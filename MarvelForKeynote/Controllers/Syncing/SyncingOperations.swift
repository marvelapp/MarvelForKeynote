//
//  SyncingOperations.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 16/03/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Foundation

protocol SyncingOperationsDelegate {
    func queueChanged()
    func cancelled()
    func finished()
}

class SyncingOperations: OperationQueue {

    var finishedSyncing = [SyncingOperation]()
    var delegate: SyncingOperationsDelegate?

    override init(){
        super.init()
        name = "Syncing queue"
        maxConcurrentOperationCount = 1
    }

    override func cancelAllOperations() {
        super.cancelAllOperations()
        finishedSyncing = [SyncingOperation]()
        delegate?.cancelled()
    }

    func addOperation(syncingOperation: SyncingOperation) {

        syncingOperation.completionHandler = { syncingOperation in
            self.finishedSyncing.append(syncingOperation)

            if self.operationCount == 0{
                self.delegate?.finished()
            } else {
                self.delegate?.queueChanged()
            }

        }

        addOperation(syncingOperation)
        delegate?.queueChanged()

    }



}
