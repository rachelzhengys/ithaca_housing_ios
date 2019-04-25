//
//  ModalViewController.swift
//  Ithaca Housing
//
//  Created by RachelZheng on 24/4/2019.
//  Copyright © 2019 YISU ZHENG. All rights reserved.
//

import Foundation
import UIKit

class ModalViewController: UIViewController {
    var houseImage: UIImageView!
    var houseLocation: UITextView!
    var housePrice: UITextView!
    var houseType: UITextView!
    var contact: UITextView!
    var postDate: UITextView!
//    var delegate: ChangeViewControllerLabels!
    
    var houseHolder: Houses
    var imageHolder: String
    var locationHolder: String
    var priceHolder: String
    var typeHolder: String
    var contactHolder: String
    var dateHolder: String

    // Creating a custom initializer for a ViewController
    init(houseHolder: Houses) {
        self.houseImage = UIImageView(image: UIImage(named: houseHolder.image))
        self.houseLocation.text = houseHolder.location
        self.housePrice.text = houseHolder.price
        self.houseType.text = houseHolder.type
        self.contact.text = houseHolder.contact
        self.postDate.text = houseHolder.postDate
        super.init(nibName: nil, bundle: nil)
    }

    // This function is required, you can ignore it
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        houseImage = UIImageView()
        houseImage.image = UIImage(named: imageHolder)
        houseImage.contentMode = .scaleAspectFill
        houseImage.translatesAutoresizingMaskIntoConstraints = false
        houseImage.clipsToBounds = true
        view.addSubview(houseImage)
        
        houseLocation = UITextView()
        houseLocation.translatesAutoresizingMaskIntoConstraints = false
        houseLocation.text = locationHolder
        houseLocation.textColor = .black
        houseLocation.textAlignment = .center
        view.addSubview(houseLocation)
        
        housePrice = 
        view.addSubview(housePrice)
        view.addSubview(houseType)
        view.addSubview(contact)
        view.addSubview(postDate)
        
        setupConstraints()
    }

    func setupConstraints() {
        // textField constraints
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 24)
            ])
        
        // button constraints
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 48)
            ])
    }

    @objc func dismissViewControllerAndSaveText() {
        // If let statements can also chain boolean checks after them, like a normal if statement.
        if let text = textField.text, text != "" {
            // Here, we're delegating someone to handle when the button title has changed
            // We don't know if anyone heard, but if they did, they should handle it
            // The method for textFieldTextChanged(to:) is in ViewController.
            
            delegate?.textFieldTextChanged(to: text)
        }
        // To dismiss something modally, we use the dismiss(animated:completion) command.
        dismiss(animated: true, completion: nil)
    }
}

