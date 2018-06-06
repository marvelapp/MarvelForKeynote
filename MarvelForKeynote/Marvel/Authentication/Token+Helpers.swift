//
//  Token+Helpers.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 05/04/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Cocoa

extension Token {

    func expired() -> Bool{

        guard let createdAt = createdAt else{
            return true
        }

        guard let expireDate = Calendar.current.date(byAdding: .second, value: Int(expiresIn), to: createdAt) else {
            return true
        }

        if expireDate < Date(){
            return true
        } else {
            return false
        }

    }

    func refresh(completion: @escaping (Token?, Error?) -> Void){

        guard let refreshToken = refreshToken else {
            completion(nil, nil)
            return
        }

        AuthenticationManager.shared.oAuthManager.refreshToken(refreshToken) { (response, error) in

            let context = (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

            guard let response = response else {
                return
            }

            self.accessToken = response.accessToken
            self.expiresIn = Double(response.expiresIn)
            self.refreshToken = response.refreshToken
            self.scope = response.scope
            self.tokenType = response.tokenType
            self.createdAt = Date()

            do {
                try context.save()
                completion(self, nil)
            } catch {
                completion(nil,nil)
            }

        }

    }

    func refreshIfNeeded(completion: @escaping (Token?, Error?) -> Void){

        if expired(){
            refresh(completion: completion)
        } else {
            completion(self, nil)
        }

    }

}
