//
//  NSCacheHelper.swift
//  PersistenceReview-InstructorNotes
//
//  Created by C4Q on 1/3/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

//this is a fancy dictionary - it's smart enough to not get too big, it knows how to clear things you haven't used for a while, on its own
class NSCacheHelper {
    private init() {}
    static let manager = NSCacheHelper()
    
    //has to be NSString because it's leftover objc code
    private var myCache = NSCache<NSString, UIImage>()
    
    func getImage(withKey key: String) -> UIImage? {
        return myCache.object(forKey: key as NSString)
    }
    
    func addImage(_ image: UIImage, withURLString key: String) {
        myCache.setObject(image, forKey: key as NSString)
    }
}
