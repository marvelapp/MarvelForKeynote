//
//  Request.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 16/03/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Foundation
import SwiftyJSON

class Request {

    var urlRequest: URLRequest
    var urlSession: URLSession
    let boundary = "Boundary-\(NSUUID().uuidString)"

    enum Method: String{
        case post = "POST"
        case get = "GET"
    }

    init(url: String, method: Method, token: String) {

        let config = URLSessionConfiguration.default
        urlSession = URLSession(configuration: config)

        let url = URL(string: url)!

        urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 30.0
        urlRequest.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = method.rawValue

    }

    func start(completion: @escaping (JSON?, URLResponse?, Error?) -> Void){

        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in

            guard let data = data else {
                completion(nil, response, error)
                return
            }

            let json = try? JSON(data: data)
            completion(json, response, error)

        }

        dataTask.resume()

    }

    func addBody(parameters: [String: String], data: Data, mimeType: String, filename: String) {

        var body = urlRequest.httpBody ?? Data()

        let boundaryPrefix = "--\(boundary)\r\n"

        for (key, value) in parameters {
            body.append(boundaryPrefix)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }

        body.append(boundaryPrefix)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.append("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.append("\r\n")
        body.append("--".appending(boundary.appending("--")))

        urlRequest.httpBody = body

    }

}
