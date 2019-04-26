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
    var houseLocation: UILabel = UILabel()
    var housePrice: UILabel!
    var houseType: UILabel!
    var contact: UILabel!
    var postDate: UILabel!
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
//        self.houseImage = UIImageView(image: UIImage(named: houseHolder.image))
        self.imageHolder = houseHolder.image
        self.locationHolder = "Location: " + houseHolder.location
        self.priceHolder = "Price(/month): " + houseHolder.price
        self.typeHolder = "Housing Type: " + houseHolder.type
        self.contactHolder = "Contact: " + houseHolder.contact
        self.dateHolder = "Post Date: " + houseHolder.postDate
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
        houseImage.translatesAutoresizingMaskIntoConstraints = false
        houseImage.clipsToBounds = true
        houseImage.bounds = view.bounds
        view.addSubview(houseImage)
        
        let layer0 = CALayer()
        layer0.contents = houseImage
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.21, tx: 0, ty: -0.1))
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)
        view.layer.cornerRadius = 10

        
        houseLocation = UILabel()
        houseLocation.translatesAutoresizingMaskIntoConstraints = false
        houseLocation.text = locationHolder
        houseLocation.textColor = UIColor(red: 0.07, green: 0.2, blue: 0.13, alpha: 0.71)
        houseLocation.font = UIFont(name: "Quicksand-Bold", size: 22)
        houseLocation.textAlignment = .center
        view.addSubview(houseLocation)
        
        housePrice = UILabel()
        housePrice.translatesAutoresizingMaskIntoConstraints = false
        housePrice.text = priceHolder
        housePrice.textColor = UIColor(red: 0.92, green: 0.17, blue: 0.21, alpha: 0.69)
        housePrice.font = UIFont(name: "OstrichSans-Black", size: 22)
        housePrice.textAlignment = .center
        view.addSubview(housePrice)
        
        houseType = UILabel()
        houseType.translatesAutoresizingMaskIntoConstraints = false
        houseType.text = typeHolder
        houseType.textColor = .black
        houseType.font = UIFont(name: "OstrichSans-Black", size: 18)
        houseType.textAlignment = .center
        view.addSubview(houseType)
        
        contact = UILabel()
        contact.translatesAutoresizingMaskIntoConstraints = false
        contact.text = contactHolder
        contact.textColor = .black
        contact.font = UIFont(name: "OstrichSans-Black", size: 18)
        contact.textAlignment = .center
        view.addSubview(contact)
        
        postDate = UILabel()
        postDate.translatesAutoresizingMaskIntoConstraints = false
        postDate.text = dateHolder
        postDate.textColor = .black
        postDate.font = UIFont(name: "OstrichSans-Black", size: 18)
        postDate.textAlignment = .center
        view.addSubview(postDate)
        
        setupConstraints()
    }

    func setupConstraints() {
        // textField constraints
        NSLayoutConstraint.activate([
            houseImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            houseImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            houseImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            houseImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5)
            ])
        
        NSLayoutConstraint.activate([
            houseLocation.topAnchor.constraint(equalTo: houseImage.bottomAnchor),
            houseLocation.heightAnchor.constraint(equalToConstant: 40),
            houseLocation.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            houseLocation.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
        
        NSLayoutConstraint.activate([
            housePrice.topAnchor.constraint(equalTo: houseLocation.bottomAnchor),
            housePrice.heightAnchor.constraint(equalToConstant: 40),
            housePrice.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            housePrice.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
        
        NSLayoutConstraint.activate([
            houseType.topAnchor.constraint(equalTo: housePrice.bottomAnchor),
            houseType.heightAnchor.constraint(equalToConstant: 40),
            houseType.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            houseType.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
        
        NSLayoutConstraint.activate([
            contact.topAnchor.constraint(equalTo: houseType.bottomAnchor),
            contact.heightAnchor.constraint(equalToConstant: 40),
            contact.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            contact.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
        
        NSLayoutConstraint.activate([
            postDate.topAnchor.constraint(equalTo: contact.bottomAnchor),
            postDate.heightAnchor.constraint(equalToConstant: 30),
            postDate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            postDate.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
    }
}

