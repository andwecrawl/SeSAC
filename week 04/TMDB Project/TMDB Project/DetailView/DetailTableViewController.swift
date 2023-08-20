//
//  DetailTableViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/14.
//

import UIKit
import Kingfisher

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var mainBackImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet var DetailTableView: UITableView!
    
    
    var media: Result? {
        didSet {
            reloadInputViews()
        }
    }
    
    var actors: [CastElement] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        configureView()
    }
    
    
    func setupTableView() {
        // XIB로 따로 셀을 만들어줬을 경우에는 nib을 연결해 줘야 함
        let overviewNib = UINib(nibName: OverviewTableViewCell.identifier, bundle: nil)
        let castNib = UINib(nibName: CastingTableViewCell.identifier, bundle: nil)
        DetailTableView.register(overviewNib, forCellReuseIdentifier: OverviewTableViewCell.identifier)
        DetailTableView.register(castNib, forCellReuseIdentifier: CastingTableViewCell.identifier)
    }
}



// tableViewSetting
extension DetailTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return 5
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let media else { return UITableViewCell() }
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else {
                return UITableViewCell()
            }
            cell.overviewTextView.text = media.overview
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastingTableViewCell.identifier) as? CastingTableViewCell else { return UITableViewCell() }
            
            if actors.isEmpty {
                TMDBManager.shared.callCastRequest(movieID: media.id) { cast in
                    self.actors = cast
                    cell.actors = cast[indexPath.row]
                }
            } else {
                let row = indexPath.row
                cell.actors = actors[row]
            }
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Overview"
        } else {
            return "Cast"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        } else {
            return 90
        }
    }
    
}


extension DetailTableViewController {
    func configureView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popView))
        
        guard let media else { return }
        if let title = media.title {
            titleLabel.text = title
        } else if let title = media.originalName {
            titleLabel.text = title
        } else if let title = media.name {
            titleLabel.text = title
        } else {
            titleLabel.text = "타이틀을 불러올 수 없습니다."
        }
        
        titleLabel.addShadow(label: titleLabel)
        
        guard let posterPath = media.posterPath else { return }
        let posterURL = URL.makeImageURL(imagePath: posterPath)
        posterImageView.kf.setImage(with: posterURL)
        
        guard let backdropPath = media.backdropPath else { return }
        let backURL = URL.makeImageURL(imagePath: backdropPath)
        mainBackImageView.kf.setImage(with: backURL)
    }
    
    @objc func popView() {
        navigationController?.popViewController(animated: true)
    }
}
