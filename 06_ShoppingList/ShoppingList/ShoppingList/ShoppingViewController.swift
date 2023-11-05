//
//  ShoppingViewController.swift
//  ShoppingList
//
//  Created by yeoni on 2023/11/05.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ShoppingViewController: UIViewController {
    
    let header = HeaderView()
    
    let tableView = {
        let view = UITableView(frame: .zero)
        view.register(ShoppingTableViewCell.self, forCellReuseIdentifier: ShoppingTableViewCell.identifier)
        view.rowHeight = 55
        return view
    }()
    
    var data = Shopping()
    
    lazy var list = BehaviorSubject(value: data.list)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bind()
        
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        [header, tableView]
            .forEach({ view.addSubview($0) })
        
        header.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(80)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(4)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bind() {
        
        list
            .bind(to: tableView.rx.items(cellIdentifier: ShoppingTableViewCell.identifier, cellType: ShoppingTableViewCell.self)) { row, element, cell in
                cell.stuff = element
                cell.configurateCell()
                cell.checkboxButton.rx.tap
                    .subscribe(with: self, onNext: { owner, void in
                        owner.data.list[row].checked.toggle()
                        owner.list.onNext(owner.data.list)
                    })
                    .disposed(by: cell.disposeBag)
                cell.starButton.rx.tap
                    .subscribe(with: self, onNext: { owner, void in
                        owner.data.list[row].liked.toggle()
                        owner.list.onNext(owner.data.list)
                    })
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind(with: self) { owner, indexPath in
                let vc = EditViewController()
                vc.completionHandler = { text in
                    owner.data.list[indexPath.row].name = text
                    owner.list.onNext(owner.data.list)
                }
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemDeleted
            .subscribe(with: self, onNext: { owner, indexPath in
                let row = indexPath.row
                owner.data.list.remove(at: row)
                owner.list.onNext(owner.data.list)
            })
            .disposed(by: disposeBag)
        
        header.addButton.rx.tap
            .withLatestFrom(header.inputTextField.rx.text.orEmpty)
            .subscribe(with: self) { owner, value in
                if value.isEmpty {
                    owner.sendOneSideAlert(title: "추가할 물건을 적어 주세요!")
                } else if owner.data.containedList(str: value) {
                    owner.sendOneSideAlert(title: "이미 리스트에 존재하는 물건입니다.")
                } else {
                    let newStuff = Stuff(name: value, liked: false, checked: false)
                    owner.data.list.insert(newStuff, at: 0)
                }
                owner.list.onNext(owner.data.list)
            }
            .disposed(by: disposeBag)
        
        header.inputTextField.rx.text.orEmpty
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(with: self) { owner, value in
                let result = value.isEmpty ? owner.data.list : owner.data.list.filter{ $0.name.contains(value) }
                owner.list.onNext(result)
            }
            .disposed(by: disposeBag)
        
    }
    
    func sendOneSideAlert(title: String, message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "okay", style: .default, handler: nil)
        alert.addAction(okay)
        present(alert, animated: true)
    }
    
}
