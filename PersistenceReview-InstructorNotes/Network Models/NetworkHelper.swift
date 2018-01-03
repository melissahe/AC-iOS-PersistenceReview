//
//  NetworkHelper.swift
//  PersistenceReview-InstructorNotes
//
//  Created by C4Q  on 1/2/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

enum AppError: Error {
    case noData
}

//URLCache - dictionary mapping url request to url responses
class NetworkHelper {
    private init() {
        urlSession.configuration.requestCachePolicy = .returnCacheDataElseLoad
    }
    static let manager = NetworkHelper()
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    func performDataTask(with request: URLRequest, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        
        //checks to see if we've made this network request before, and if yes, returns the cached response
        if let response = URLCache.shared.cachedResponse(for: request) {
            completionHandler(response.data)
        }
        
        //if not, it makes the network request and caches response
        self.urlSession.dataTask(with: request){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {errorHandler(AppError.noData); return}
                if let error = error {
                    errorHandler(error)
                }
                completionHandler(data)
                
            }
            }.resume()
    }
}

