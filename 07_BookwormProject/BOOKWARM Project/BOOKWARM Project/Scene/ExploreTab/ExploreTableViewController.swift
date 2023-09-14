//
//  ExploreTableViewController.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/08/02.
//

import UIKit

class ExploreTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    let randomList = MovieList().list.shuffled()
    let list = MovieList().list.shuffled()
    
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        let nib = UINib(nibName: "bannerCollectionViewCell", bundle: nil)
        bannerCollectionView.register(nib, forCellWithReuseIdentifier: "bannerCollectionViewCell")
        
        configureBestCollectionViewLayout()
    }
    
    
    // bannerCollectionView Setting
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        
        cell.movie = randomList[indexPath.row]
        cell.configurateBanner()
        
        return cell
    }
    
    
    func configureBestCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 230)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        bannerCollectionView.collectionViewLayout = layout
        bannerCollectionView.isPagingEnabled = true
    }
    
    
    // TableView Setting
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreTableViewCell", for: indexPath) as? ExploreTableViewCell else { return UITableViewCell() }
        
        cell.movie = list[indexPath.row]
        cell.configurateCell()
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "  요즘 인기 작품"
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.textLabel?.textColor = .black
        header.textLabel?.frame = header.bounds
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        
        vc.movie = list[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
