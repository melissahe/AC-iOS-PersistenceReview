//
//  ImagesHistoryViewController.swift
//  PersistenceReview-InstructorNotes
//
//  Created by C4Q on 1/3/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class ImagesHistoryViewController: UIViewController {

    var images: [NasaImage] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)
        
        loadImages()
        configureConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadImages()
    }
    
    func loadImages() {
        self.images = FileManagerHelper.manager.getAllNasaImages()
    }

    func configureConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
    }
    
}

extension ImagesHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let nasaImage = images[indexPath.row]
        cell.textLabel?.text = nasaImage.title
        cell.imageView?.image = nil
        cell.imageView?.contentMode = .scaleAspectFit
        ImageAPIClient.manager.loadImage(from: nasaImage.url, completionHandler: { (onlineImage) in
            cell.imageView?.image = onlineImage
            cell.setNeedsLayout()
        }, errorHandler: { (error) in
            print(error)
        })
        
        return cell
    }
}
