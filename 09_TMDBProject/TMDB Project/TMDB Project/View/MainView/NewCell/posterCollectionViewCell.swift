//
//  posterCollectionViewCell.swift
//  TMDB Project
//
//  Created by yeoni on 2023/12/02.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    var media: Result?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell() {
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.layer.cornerRadius = 8
        
    }
    
    func configureCell() {
        guard let media else { return }
        guard let poster = media.posterPath else { return }
        
        let url = URL.makeImageURL(imagePath: poster)
        imageView.kf.setImage(with: url)
    }
    
    
}
