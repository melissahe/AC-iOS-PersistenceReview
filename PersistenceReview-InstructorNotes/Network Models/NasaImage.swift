//
//  NasaImage.swift
//  PersistenceReview-InstructorNotes
//
//  Created by C4Q  on 1/2/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct NasaImage: Codable, Equatable {
    let title: String
    let url: String
    
    static func ==(lhs: NasaImage, rhs: NasaImage) -> Bool {
        return lhs.title == rhs.title && lhs.url == rhs.url
    }
}

struct NasaAPIClient {
    private init(){}
    static let shared = NasaAPIClient()
    func getNasaImage(from urlStr: String,
                   completionHandler: @escaping (NasaImage) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let things = try JSONDecoder().decode(NasaImage.self, from: data)
                completionHandler(things)
            }
            catch {
                print(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url),
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
