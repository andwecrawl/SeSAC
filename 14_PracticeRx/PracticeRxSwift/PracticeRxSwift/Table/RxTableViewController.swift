//
//  RxTableViewController.swift
//  PracticeRxSwift
//
//  Created by yeoni on 2023/10/31.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class RxTableViewController: UIViewController, UITableViewDelegate {
    
    let tableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return view
    }()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        configureView()
//        configureNewSample()
    }
    
    func setConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    func configureView() {
        
        let items = Observable.just(
            (0..<20).map { "\($0)" }
        )
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
                cell.accessoryType = .detailButton
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
                DefaultWireframe.presentAlert("Tapped `\(value)`")
            })
            .disposed(by: disposeBag)


        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                DefaultWireframe.presentAlert("Tapped Detail @ \(indexPath.section), \(indexPath.row)")
            })
            .disposed(by: disposeBag)
        
    }
    
    func configureNewSample() {
        
        let items = Observable.just(
            ["콩순", "해팔", "쮜", "쩨", "밤송"].map { $0 }
        )
        
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) {
                (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe { value in
                DefaultWireframe.presentAlert("tapped \(value)")
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                DefaultWireframe.presentAlert("tapped! \(indexPath.section), \(indexPath.row)")
            })
            .disposed(by: disposeBag)
//            .subscribe { indexPath in
//                DefaultWireframe.presentAlert("tapped! \(indexPath.section), \(indexPath.row)")
//            }
        
        
        
    }
}

