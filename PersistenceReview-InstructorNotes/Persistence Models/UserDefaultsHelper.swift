//
//  UserDefaultsHelper.swift
//  PersistenceReview-InstructorNotes
//
//  Created by C4Q on 1/3/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

//responsible for storing everything with userdefaults
//this means people don't need to worry about how userDefaults will work, they don't need to worry about what goes on under the hood
class UserDefaultsHelper {
    private init() {}
    static let manager = UserDefaultsHelper()
    private let numberOfLoadsKey = "numberOfLoadedImages"
    
    func incrementNumberOfLoadedImages() {
        //gives you the number of times you've stored stuff
        let loadsSoFar = UserDefaults.standard.integer(forKey: numberOfLoadsKey)
        
        UserDefaults.standard.set(loadsSoFar + 1, forKey: numberOfLoadsKey)
    }
    
    func getNumberOfImageLoads() -> Int {
        return UserDefaults.standard.integer(forKey: numberOfLoadsKey)
    }
    
}
