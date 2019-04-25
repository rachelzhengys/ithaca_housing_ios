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
    weak var delegate: ViewController?
//    var delegate: ChangeViewControllerLabels!
    
    var houseHolder: Houses!
    var imageHolder: String!
    var locationHolder: String!
    var priceHolder: String!
    var typeHolder: String!
    var contactHolder: String!
    var dateHolder: String!

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
        
        housePrice = UITextView()
        housePrice.translatesAutoresizingMaskIntoConstraints = false
        housePrice.text = priceHolder
        housePrice.textColor = .black
        housePrice.textAlignment = .center
        view.addSubview(housePrice)
        
        houseType = UITextView()
        houseType.translatesAutoresizingMaskIntoConstraints = false
        houseType.text = typeHolder
        houseType.textColor = .black
        houseType.textAlignment = .center
        view.addSubview(houseType)
        
        contact = UITextView()
        contact.translatesAutoresizingMaskIntoConstraints = false
        contact.text = contactHolder
        contact.textColor = .black
        contact.textAlignment = .center
        view.addSubview(contact)
        
        postDate = UITextView()
        postDate.translatesAutoresizingMaskIntoConstraints = false
        postDate.text = dateHolder
        postDate.textColor = .black
        postDate.textAlignment = .center
        view.addSubview(postDate)
        
        setupConstraints()
    }

    func setupConstraints() {
        // textField constraints
        NSLayoutConstraint.activate([
            houseImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            houseImage.heightAnchor.constraint(equalToConstant: 300),
            houseImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            houseImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
        
        NSLayoutConstraint.activate([
            houseLocation.topAnchor.constraint(equalTo: houseImage.bottomAnchor),
            houseLocation.heightAnchor.constraint(equalToConstant: 30),
            houseLocation.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            houseLocation.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
        
        NSLayoutConstraint.activate([
            housePrice.topAnchor.constraint(equalTo: houseLocation.bottomAnchor),
            housePrice.heightAnchor.constraint(equalToConstant: 30),
            housePrice.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            housePrice.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
        
        NSLayoutConstraint.activate([
            houseType.topAnchor.constraint(equalTo: housePrice.bottomAnchor),
            houseType.heightAnchor.constraint(equalToConstant: 30),
            houseType.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            houseType.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
        
        NSLayoutConstraint.activate([
            contact.topAnchor.constraint(equalTo: houseType.bottomAnchor),
            contact.heightAnchor.constraint(equalToConstant: 30),
            contact.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            contact.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
        
        NSLayoutConstraint.activate([
            postDate.topAnchor.constraint(equalTo: contact.bottomAnchor),
            postDate.heightAnchor.constraint(equalToConstant: 20),
            postDate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            postDate.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
    }
}

