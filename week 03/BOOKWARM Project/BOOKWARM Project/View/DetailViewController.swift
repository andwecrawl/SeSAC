//
//  DetailViewController.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/08/01.
//

import UIKit

class DetailViewController: UIViewController {
   
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    
    @IBOutlet weak var likedButton: UIButton!
   
    @IBOutlet weak var cardView: UIView!
    
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designInitalSetting()
    }
    
    func designInitalSetting() {
        guard let movie else {
            return
        }
        
        let movieTitle = movie.name
        posterImageView.image = UIImage(named: movieTitle)
        titleLabel.text = movieTitle
        detailLabel.text = movie.description
        plotLabel.textAlignment = .justified
        plotLabel.text = movie.plot
        makeShadow(view: cardView)
        
        if movie.liked {
            let likedImage = UIImage(systemName: "heart.fill")
            likedButton.setImage(likedImage, for: .normal)
            likedButton.tintColor = .systemRed
        } else {
            let unlikedImage = UIImage(systemName: "heart")
            likedButton.setImage(unlikedImage, for: .normal)
        }
    }
    
    @IBAction func likedButtonTapped(_ sender: UIButton) {
        
    }
    
    func makeShadow(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        view.layer.shadowRadius = 60
        view.layer.shadowOpacity = 1
        view.clipsToBounds = false
    }
}
