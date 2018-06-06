//
//  Calls.swift
//  MarvelForKeynote
//
//  Created by Maxime De Greve on 05/03/2018.
//  Copyright © 2018 Marvel Prototyping. All rights reserved.
//

import Foundation
import SwiftyJSON

class Calls {

    // MARK: GraphQL Helpers

    func graphQL(query: String, accessToken: String, completion: @escaping (JSON?, URLResponse?, Error?) -> Void){

        let request = Request(url: "\(Secrets.Marvel.baseURL)/graphql/", method: .post, token: accessToken)

        let json = ["query": query]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.urlRequest.httpBody = jsonData

        request.start(completion: completion)

    }

    func projectsIncludingCompany(accessToken: String, completion: @escaping (JSON?, URLResponse?, Error?) -> Void){

        let query = """
            query {
                  user {
                    company {
                      projects(first: 40) {
                        edges {
                          node {
                            pk
                            name
                            prototypeUrl
                            lastModified
                          }
                        }
                      }
                    }
                    projects(first: 40) {
                      edges {
                        node {
                          pk
                          name
                          prototypeUrl
                          lastModified
                        }
                      }
                    }
                  }
                }
            """

        graphQL(query: query, accessToken: accessToken, completion: completion)

    }



    func project(accessToken: String, pk: Int, completion: @escaping (JSON?, URLResponse?, Error?) -> Void){

        let query = """
        fragment image on ImageScreen {
            filename
            url
            height
            width
        }

        query {
          project(pk: \(pk)) {
            name
            pk
            lastModified
            screens(first: 100) {
              edges {
                node {
                  name
                  modifiedAt
                  uploadUrl
                  content {
                    __typename
                    ... image
                  }
                }
              }
            }
          }
        }
        """

        graphQL(query: query, accessToken: accessToken, completion: completion)

    }

    func createScreen(accessToken: String, projectPk: Int, name: String, completion: @escaping (JSON?, URLResponse?, Error?) -> Void){

        let query = """
        mutation {
        createScreen(input: {projectPk: \(projectPk), name: "\(name)"}) {
            ok
            screen {
              pk
              uploadUrl
              content {
                ... on ImageScreen {
                  url
                }
              }
            }
          }
        }
        """

        graphQL(query: query, accessToken: accessToken, completion: completion)

    }

    func upload(accessToken: String, url: String, fileURL: URL, completion: @escaping (JSON?, URLResponse?, Error?) -> Void){

        let request = Request(url: url, method: .post, token: accessToken)
        request.urlRequest.setValue("multipart/form-data; boundary=\(request.boundary)", forHTTPHeaderField: "Content-Type")

        guard let fileData = try? Data(contentsOf: fileURL) else {
            Swift.print("Couldn't get the data of \(fileURL.lastPathComponent)")
            return
        }

        request.addBody(parameters: [:], data: fileData, mimeType: "image/png", filename: fileURL.lastPathComponent)
        request.start(completion: completion)

    }

    
}


