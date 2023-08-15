//
//  DetailTableViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/14.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var mainBackImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet var DetailTableView: UITableView!
    
    
    var media: TrendMedia?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainBackImageView.image = UIImage(named: "testImage")
        titleLabel.text = "안녕하세요?"
        
        // XIB로 따로 셀을 만들어줬을 경우에는 nib을 연결해 줘야 함
        let overviewNib = UINib(nibName: OverviewTableViewCell.identifier, bundle: nil)
        let castNib = UINib(nibName: CastingTableViewCell.identifier, bundle: nil)
        DetailTableView.register(overviewNib, forCellReuseIdentifier: OverviewTableViewCell.identifier)
        DetailTableView.register(castNib, forCellReuseIdentifier: CastingTableViewCell.identifier)
        
        
    }
    
    func configureView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popView))
        guard let media else { return }
        title = media.title
        
    }
    
    @objc func popView() {
        navigationController?.popViewController(animated: true)
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
            return 20
        }    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else {
                return UITableViewCell()
                
            }
            cell.overviewTextView.text = "개요입니당"
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastingTableViewCell.identifier) as? CastingTableViewCell else {
                return UITableViewCell()
            }
            
            cell.profileImageView.image = UIImage(named: "testImage")
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
