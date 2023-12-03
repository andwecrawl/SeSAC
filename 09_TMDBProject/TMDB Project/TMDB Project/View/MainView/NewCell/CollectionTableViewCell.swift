//
//  CollectionTableViewCell.swift
//  TMDB Project
//
//  Created by yeoni on 2023/12/02.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var introduceLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell() {
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        let title = [ "감동적인 드라마", "짜릿한 액션과 모험", "오싹한 스릴러", "골때리는 코미디", "인기 있는 영화", "최고의 드라마 모음" ].randomElement()!
        introduceLabel.text = title
    }
    
    
}
