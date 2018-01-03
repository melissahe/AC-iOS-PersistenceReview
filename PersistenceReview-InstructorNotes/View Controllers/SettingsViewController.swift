//
//  SettingsViewController.swift
//  PersistenceReview-InstructorNotes
//
//  Created by C4Q on 1/3/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    lazy var loadNumLabel: UILabel = {
        let label = UILabel()
        
        label.text = "You have loaded \(UserDefaultsHelper.manager.getNumberOfImageLoads()) images."
        
        return label
    }()
    
    lazy var nameEntryTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 300, width: 300, height: 200))
        
        if let savedName = UserDefaultsHelper.manager.getName() {
            textField.text = savedName
        }
        
        return textField
    }()
    
    lazy var saveNameButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 550, width: 100, height: 100))
        
        button.setTitle("Save Settings", for: .normal)
        button.addTarget(self, action: #selector(saveName), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        [loadNumLabel, nameEntryTextField, saveNameButton].forEach{self.view.addSubview($0)}
        loadNumLabel.translatesAutoresizingMaskIntoConstraints = false
        loadNumLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadNumLabel.text = "You have loaded \(UserDefaultsHelper.manager.getNumberOfImageLoads()) images."
    }

    @objc func saveName() {
        if let newName = nameEntryTextField.text {
            UserDefaultsHelper.manager.saveName(newName)
        }
    }
    
}
