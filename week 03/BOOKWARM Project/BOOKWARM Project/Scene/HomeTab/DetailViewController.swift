//
//  DetailViewController.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/08/01.
//

import UIKit

class DetailViewController: UIViewController {
   
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    
    @IBOutlet weak var likedButton: UIButton!
   
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var memoTextView: UITextView!
    
    
    var movie: Movie?
    var hidden: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButtonChecked()
        designInitalSetting()
        blurPosterImageView()
        
        NSLayoutConstraint.activate([
        cardView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -50)
      ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)

    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func endEditing() {
        view.endEditing(true)
    }
    
    func closeButtonChecked() {
        closeButton.isHidden = hidden
        if closeButton.isHidden {
            closeButton.isEnabled = false
        } else {
            closeButton.isEnabled = true
        }
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
        
        memoTextView.layer.borderColor = UIColor.darkGray.cgColor
        memoTextView.layer.borderWidth = 1
        memoTextView.layer.opacity = 0.4
        memoTextView.layer.cornerRadius = 10
    }
    
    func blurPosterImageView() {
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.view.frame
        visualEffectView.alpha = 0.3
        self.posterImageView.addSubview(visualEffectView)
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
