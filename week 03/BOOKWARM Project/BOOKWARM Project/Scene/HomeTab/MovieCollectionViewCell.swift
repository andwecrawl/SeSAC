//
//  MovieCollectionViewCell.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/07/31.
//

import UIKit
import RealmSwift

class MovieCollectionViewCell: UICollectionViewCell {
    
    var movie: Movie?
    var book: BookTable?
    
    @IBOutlet weak var backImageVIew: UIImageView!
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var likedButton: UIButton!
    
    @IBOutlet weak var backView: UIView!
    
    //    let nameLabel = UILabel.labelBuilder(size: 13, weight: .bold)
    //    let rateLabel = UILabel.labelBuilder(size: 10, weight: .medium)
    //    let posterImageView =
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.font = .boldSystemFont(ofSize: 15)
        nameLabel.numberOfLines = 2
        rateLabel.font = .systemFont(ofSize: 12)
        
        likedButton.addTarget(self, action: #selector(likedButtonClicked), for: .touchUpInside)
    }
    
    @objc func likedButtonClicked() {
        if var movie = movie {
            movie.liked.toggle()
            // movieData 전달 코드 필요
        } else if let book = book {
            if book.liked {
                let likedImage = UIImage(systemName: "heart.fill")
                likedButton.setImage(likedImage, for: .normal)
                likedButton.tintColor = .systemRed
            } else {
                let unlikedImage = UIImage(systemName: "heart")
                likedButton.setImage(unlikedImage, for: .normal)
                likedButton.tintColor = .gray
            }
            book.liked.toggle()
        }
    }
    
    func fillCell() {
        guard let movie else {
            return
        }
        
        nameLabel.text = movie.name
        let image = UIImage(named: movie.name)
        backImageVIew.image = image
        posterImageView.image = image
        rateLabel.text = movie.description
        likedButton.tintColor = .gray
        backView.backgroundColor = movie.color
        
        if movie.liked {
            let likedImage = UIImage(systemName: "heart.fill")
            likedButton.setImage(likedImage, for: .normal)
            likedButton.tintColor = .systemRed
        } else {
            let unlikedImage = UIImage(systemName: "heart")
            likedButton.setImage(unlikedImage, for: .normal)
        }
    }
    
    func makeImageView(outerView: UIView, innerView: UIView) {
        // 그림자랑 cornerRadius 수정
        innerView.layer.cornerRadius = 15
        innerView.clipsToBounds = true
        outerView.layer.cornerRadius = 15
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOffset = .zero
        outerView.layer.shadowRadius = 10
        outerView.layer.shadowOpacity = 0.3
    }
    
    func setupBookUI() {
        guard let book else { return }
        
        nameLabel.text = book.title
        rateLabel.text = book.authors
        if let thumb = book.thumbnail {
            getImage(urlText: thumb)
        } else {
            posterImageView.image = UIImage(named: "noImage")
            backImageVIew.image = UIImage(named: "noImage")
        }
        
        if book.liked {
            let likedImage = UIImage(systemName: "heart.fill")
            likedButton.setImage(likedImage, for: .normal)
            likedButton.tintColor = .systemRed
        } else {
            let unlikedImage = UIImage(systemName: "heart")
            likedButton.setImage(unlikedImage, for: .normal)
            likedButton.tintColor = .gray
        }
    }
    
    func getImage(urlText: String) {
        let url = URL(string: urlText)
        
        DispatchQueue.global().async {
            guard let url else { return }
            
            let data = try! Data(contentsOf: url)
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.backImageVIew.image = image
                self.posterImageView.image = image
            }
        }
    }
}
