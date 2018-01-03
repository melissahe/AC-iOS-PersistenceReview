//
//  ViewController.swift
//  PersistenceReview-InstructorNotes
//
//  Created by C4Q  on 1/2/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class NasaImageViewController: UIViewController {
    
    var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = UIDatePickerMode.date
        dp.maximumDate = Date()
        return dp
    }()
    
    var loadImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Load Image", for: .normal)
        button.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
        button.backgroundColor = .green
        return button
    }()
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .cyan
        return iv
    }()
    
    @objc func loadImage() {
        let date = datePicker.date.description.components(separatedBy: " ")[0]
        let key = "9ZYwVaMFnyAPYOm4yy8djSZkhMtuT69QGURFd6km"
        let str = "https://api.nasa.gov/planetary/apod?date=\(date)&api_key=\(key)"
        NasaAPIClient.shared.getNasaImage(from: str,
                                          completionHandler: {
                                            ImageAPIClient.manager.loadImage(from: $0.url,
                                                                             completionHandler: {self.imageView.image = $0
                                                                                self.imageView.setNeedsLayout()
                                                                                UserDefaultsHelper.manager.incrementNumberOfLoadedImages()
                                                                                
                                            },
                                                                             errorHandler: {print($0)})
                                            
                                            },
                                          errorHandler: {print($0)})
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addSubViews()
        configureConstraints()
    }
    
    func addSubViews() {
        self.view.addSubview(datePicker)
        self.view.addSubview(loadImageButton)
        self.view.addSubview(imageView)
    }
    
    func configureConstraints() {
        loadImageButton.translatesAutoresizingMaskIntoConstraints = false
        loadImageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        loadImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.bottomAnchor.constraint(equalTo: loadImageButton.topAnchor, constant: -20).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePicker.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.bottomAnchor.constraint(equalTo: datePicker.topAnchor, constant: 20).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }
}

