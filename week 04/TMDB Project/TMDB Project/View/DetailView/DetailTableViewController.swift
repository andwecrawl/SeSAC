//
//  DetailTableViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/14.
//

import UIKit
import Kingfisher

class DetailTableViewController: BaseViewController {
    
    @IBOutlet weak var mainBackImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet var DetailTableView: UITableView!
    
    let mainView = DetailView()
    
    var media: Result? {
        didSet {
            reloadInputViews()
        }
    }
    
    var actors: [CastElement] = []
    var isExpand: Bool = false
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureView() {
        super.configureView()
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popView))
    }
}



// tableViewSetting
extension DetailTableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let media else { return UITableViewCell() }
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CodeOverviewTableViewCell.identifier) as? CodeOverviewTableViewCell else {
                return UITableViewCell()
            }
            
            if let overview = media.overview {
                cell.overviewLabel.text = "\n" + overview
            } else {
                cell.overviewLabel.text = "줄거리를 불러올 수 없습니다."
            }
            cell.overviewLabel.numberOfLines = isExpand ? 0 : 5
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else { return UITableViewCell() }
            
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Overview"
        } else {
            return "Cast"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            isExpand.toggle()
        }
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DetailHeaderView.headerViewID) as? DetailHeaderView else { return UIView() }
        
        if section == 0 {
            guard let media else { return UIView() }
            if let title = media.title {
                header.titleLabel.text = title
            } else if let title = media.originalName {
                header.titleLabel.text = title
            } else if let title = media.name {
                header.titleLabel.text = title
            } else {
                header.titleLabel.text = "타이틀을 불러올 수 없습니다."
            }
            
            let image = UIImage(named: "noImage")
            if let posterPath = media.posterPath {
                let posterURL = URL.makeImageURL(imagePath: posterPath)
                header.posterImageView.kf.setImage(with: posterURL)
            } else {
                header.posterImageView.image = image
            }
            
            if let backdropPath = media.backdropPath {
                let backURL = URL.makeImageURL(imagePath: backdropPath)
                header.mainBackImageView.kf.setImage(with: backURL)
            } else {
                header.mainBackImageView.image = image
            }
            
            return header
        } else {
            return nil
        }
    }
    
    @objc func popView() {
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 210
        } else {
            return 0
        }
    }
}


