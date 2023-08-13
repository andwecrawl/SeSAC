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
    
    var media: TrendsMedia?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainBackImageView.image = UIImage(named: "testImage")
        titleLabel.text = "안녕하세요?"
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        } else {
            return 20
        }    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else {
                print("alreadyDead")
                return UITableViewCell()
                
            }
            cell.overviewTextView.text = "개요입니당"
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else {
                
                print("dead")
                return UITableViewCell()
            }
            
            print("hi")
            cell.castImageView.image = UIImage(named: "testImage")
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
            return 160
        } else {
            return 100
        }
    }

}
