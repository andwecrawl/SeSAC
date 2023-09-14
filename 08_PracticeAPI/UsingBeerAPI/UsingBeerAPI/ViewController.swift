//
//  ViewController.swift
//  UsingBeerAPI
//
//  Created by yeoni on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class ViewController: UIViewController {
    
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var randomButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest()
        configureButton()
    }
    
    
    func callRequest() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let name = json[0]["name"].stringValue
                let description =  json[0]["description"].stringValue
                let firstBrewed = json[0]["first_brewed"].stringValue
                let contributedBy = json[0]["contributed_by"].stringValue
                let imageURL = URL(string: json[0]["image_url"].stringValue)
                
                print(imageURL)
                self.nameLabel.text = name
                self.beerImageView.kf.setImage(with: imageURL)
                self.foodLabel.text = "\(contributedBy) · \(firstBrewed)"
                self.descriptionLabel.text = description
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureButton() {
        randomButton.backgroundColor = .yellow
        randomButton.layer.cornerRadius = 20
        randomButton.setTitle("RandomBeer", for: .normal)
        randomButton.setTitleColor(.darkGray, for: .normal)
    }
    
    
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        
        callRequest()
    }
    
    
}

