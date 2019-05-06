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
    var postDate: UILabel!
    var link: UILabel!
    var exitBarButton: UIBarButtonItem!
    var urlLabel: UILabel!
    weak var delegate: ViewController?
//    var delegate: ChangeViewControllerLabels!
    
    var houseHolder: Houses!
    var imageHolder: String!
    var locationHolder: String!
    var priceHolder: String!
    var typeHolder: String!
    var contactHolder: String!
    var dateHolder: String!
    var urlHolder: String!

    // Creating a custom initializer for a ViewController
    init(houseHolder: Houses) {
//        self.houseImage = UIImageView(image: UIImage(named: houseHolder.image))
        self.imageHolder = houseHolder.imageurl
        self.locationHolder = "Location: " + houseHolder.location
        self.priceHolder = "Price(/month): " + String (houseHolder.price)
        self.typeHolder = "Housing Type: " + houseHolder.type
        self.dateHolder = "Post Date: " + houseHolder.postdate
        self.urlHolder = "Post URL: " + houseHolder.houseurl
        super.init(nibName: nil, bundle: nil)
    }

    // This function is required, you can ignore it
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        exitBarButton = UIBarButtonItem(title: "Exit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissToMainPage))
        self.navigationItem.rightBarButtonItem = exitBarButton
        
        
        houseImage = UIImageView()
        getHouseImage(url: imageHolder)
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
        houseLocation.textColor = .gray
        houseLocation.font = UIFont(name: "Quicksand-Bold", size: 24)
        view.addSubview(houseLocation)
        
        housePrice = UILabel()
        housePrice.translatesAutoresizingMaskIntoConstraints = false
        housePrice.text = priceHolder
        housePrice.textColor = .gray
        housePrice.font = UIFont(name: "Helvetica-Regular", size: 22)
        view.addSubview(housePrice)
        
        houseType = UILabel()
        houseType.translatesAutoresizingMaskIntoConstraints = false
        houseType.text = typeHolder
        houseType.textColor = .gray
        houseType.font = UIFont(name: "Helvetica-Regular", size: 18)
        view.addSubview(houseType)
        
        urlLabel = UILabel()
        urlLabel.translatesAutoresizingMaskIntoConstraints = false
        urlLabel.text = urlHolder
        urlLabel.textColor = .gray
        urlLabel.font = UIFont(name: "Helvetica-Regular", size: 18)
        urlLabel.numberOfLines = 0
        view.addSubview(urlLabel)
        
        postDate = UILabel()
        postDate.translatesAutoresizingMaskIntoConstraints = false
        postDate.text = dateHolder
        postDate.textColor = .gray
        postDate.font = UIFont(name: "Helvetica-Regular", size: 18)
        view.addSubview(postDate)
        
        setupConstraints()
    }
    @objc func dismissToMainPage(){
        dismiss(animated: true, completion: nil)
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
            postDate.topAnchor.constraint(equalTo: houseType.bottomAnchor),
            postDate.heightAnchor.constraint(equalToConstant: 30),
            postDate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            postDate.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            urlLabel.topAnchor.constraint(equalTo: postDate.bottomAnchor),
            urlLabel.heightAnchor.constraint(equalToConstant: 90),
            urlLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            urlLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
    }
    @objc func getHouseImage(url: String){
        NetworkManager.fetchHouseImage (imageURL: url){(houseImage) in
            DispatchQueue.main.async {
                self.houseImage.image = houseImage
            }
        }
    }
    
}

