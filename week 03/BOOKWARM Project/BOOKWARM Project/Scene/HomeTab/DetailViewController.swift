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
    
    @IBOutlet weak var memoTextView: UITextView!
    
    
    var movie: Movie?
    var book: BookTable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designInitalSetting()
        configureView()
        blurPosterImageView()
        

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)

    }
    
    @objc func endEditing() {
        view.endEditing(true)
    }
    
    func designInitalSetting() {

        if let movie = movie {
            
            let movieTitle = movie.name
            posterImageView.image = UIImage(named: movieTitle)
            titleLabel.text = movieTitle
            detailLabel.text = movie.description
            plotLabel.textAlignment = .justified
            plotLabel.text = movie.plot
            
            if movie.liked {
                let likedImage = UIImage(systemName: "heart.fill")
                likedButton.setImage(likedImage, for: .normal)
                likedButton.tintColor = .systemRed
            } else {
                let unlikedImage = UIImage(systemName: "heart")
                likedButton.setImage(unlikedImage, for: .normal)
            }
            
        } else if let book = book {
            FileManagerHelper.shared.doSomethingToDocument(status: .load, id: book._id, image: nil) { image in
                self.posterImageView.image = image
            }
            titleLabel.text = book.title
            let description: String = "\(book.authors) · \(book.publisher) · \(book.price)"
            detailLabel.text = description
            
            print(book.description)
            plotLabel.textAlignment = .justified
            plotLabel.text = book.contents
            
        }
    }
    
    func configureView() {
        memoTextView.layer.borderColor = UIColor.lightGray.cgColor
        memoTextView.backgroundColor = .darkGray
        memoTextView.textColor = .white
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
        // 좋아요 눌렀을 때 구현!!
    }
    
    func makeShadow(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        view.layer.shadowRadius = 60
        view.layer.shadowOpacity = 1
        view.clipsToBounds = false
    }
}
