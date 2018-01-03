//
//  FileManagerHelper.swift
//  PersistenceReview-InstructorNotes
//
//  Created by C4Q on 1/3/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

//for saving in your app folders
//a different way to save things as opposed to userDefaults
//stores info in your folder to preserve data
class FileManagerHelper {
    private init() {}
    static let manager = FileManagerHelper()
    private let key = "NasaImages"
    
    private var nasaImages: [NasaImage] = [] {
        didSet {
            saveImages()
        }
    }
    
    //to get the document directory url
    private func documentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    //uses above function, appends name to URL
    private func dataFilePath(withFileName fileName: String) -> URL {
        return documentDirectory().appendingPathComponent(fileName)
    }
    
    //saving images to disk
    func saveImage(_ image: UIImage, named imageURL: String) {
        let imageData = UIImagePNGRepresentation(image)
        let imageName = imageURL.components(separatedBy: "/").last!
        
        let filePath = dataFilePath(withFileName: imageName)
        
        do {
            try imageData?.write(to: filePath, options: .atomic)
        } catch {
            print(error)
        }
    }
    
    //getting images from disk
    func getImage(named imageURL: String) -> UIImage? {
        let imageName = imageURL.components(separatedBy: "/").last!
        let filePath = dataFilePath(withFileName: imageName)
    
        do {
            let data = try Data.init(contentsOf: filePath)
            guard let image = UIImage.init(data: data) else {
                return nil
            }
            
            return image
        } catch {
            print(error)
        }
    
        return nil
    }
    
    func addNew(newNasaImage: NasaImage) {
        if !nasaImages.contains(newNasaImage) {
            nasaImages.append(newNasaImage)
        }
    }
    
    func getAllNasaImages() -> [NasaImage] {
        return nasaImages
    }
    
    private func saveImages() {
        let propertyListEncoder = PropertyListEncoder()
        let filePath = dataFilePath(withFileName: key)
        
        do {
            let encodedData = try propertyListEncoder.encode(nasaImages)
            try encodedData.write(to: filePath)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadImages() {
        let propertyListDecoder = PropertyListDecoder()
        let filePath = dataFilePath(withFileName: key)
        
        do {
            let data = try Data.init(contentsOf: filePath)
            let savedImages = try propertyListDecoder.decode([NasaImage].self, from: data)
            self.nasaImages = savedImages
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
