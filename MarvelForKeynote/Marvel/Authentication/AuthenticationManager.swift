//
//  AuthenticationManager.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 27/03/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Cocoa
import MarvelAuth

protocol AuthenticationManagerDelegate: class {
    func didLogin()
    func tokenExpired()
}

class AuthenticationManager {

    static let shared = AuthenticationManager()

    var oAuthManager: OAuthManager
    var authInfo: AuthorizationInfo
    let context = (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    weak var delegate:AuthenticationManagerDelegate?

     // MARK : Init

    init() {
        oAuthManager = OAuthManager(
            baseURL: URL(string: Secrets.Marvel.baseURL)!,
            clientId: Secrets.Marvel.clientId,
            clientSecret: Secrets.Marvel.clientSecret,
            scope: Secrets.Marvel.scopes,
            redirectURI: URL(string: Secrets.Marvel.redirectURI)! // This should be uri scheme, contact Marvel for more information.
        )
        authInfo = oAuthManager.generateAuthInfo()
        listenForExternalCallback()
    }

    // MARK : Actions
    
    func token() -> Token?{

        let fetchRequest: NSFetchRequest<Token> = Token.fetchRequest()

        if let result = try? context.fetch(fetchRequest) {
            for token in result {
                return token
            }
        }

        return nil

    }

    func deleteToken(){

        let fetchRequest: NSFetchRequest<Token> = Token.fetchRequest()

        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                context.delete(object)
            }
        }

        try? context.save()

    }

    // MARK: Login

    func login(){
        NSWorkspace.shared.open(authInfo.url)
    }

    func refreshToken(){

        AuthenticationManager.shared.token()?.refresh(completion: { (token, error) in

            if let err = error as NSError?, let statusCode = err.userInfo[OAuthHTTPErrorStatusKey] as? Int, statusCode == 401 {
                self.delegate?.tokenExpired()
            }

        })

    }

    fileprivate func listenForExternalCallback(){
        let aem = NSAppleEventManager.shared()
        aem.setEventHandler(self, andSelector: #selector(handleGetURLEvent(event:replyEvent:)), forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
    }

    fileprivate func saveToken(response: TokenResponse) -> Bool{

        // Ensures no tokens are left
        deleteToken()

        let token = Token(context: context)
        token.accessToken = response.accessToken
        token.expiresIn = Double(response.expiresIn)
        token.refreshToken = response.refreshToken
        token.scope = response.scope
        token.tokenType = response.tokenType
        token.createdAt = Date()

        do {
            try context.save()
        } catch {
            return false
        }

        return true

    }

    @objc fileprivate func handleGetURLEvent(event: NSAppleEventDescriptor, replyEvent: NSAppleEventDescriptor) {

        let urlString = event.paramDescriptor(forKeyword: AEKeyword(keyDirectObject))?.stringValue!
        let redirectURL = URL(string: urlString!)!

        guard let authCode = oAuthManager.parseAuthCodeAndVerifyState(redirectURL, authInfo: authInfo) else {
            let alert = Alert(title: "Could parse the code from the Marvel website.", subtitle: "Contact help@marvelapp.com")
            alert.show()
            return
        }

        oAuthManager.exchangeToken(authCode: authCode, authInfo: authInfo) { (response, error) in

            guard error == nil, let tokenResponse = response else {
                let alert = Alert(title: "Something went wrong with exchanging your token.", subtitle: "Contact help@marvelapp.com")
                alert.show()
                return
            }

            if self.saveToken(response: tokenResponse) == false {
                let alert = Alert(title: "Could not save your token to the database.", subtitle: "Contact help@marvelapp.com")
                alert.show()
            }

            self.delegate?.didLogin()
        }

    }

}
