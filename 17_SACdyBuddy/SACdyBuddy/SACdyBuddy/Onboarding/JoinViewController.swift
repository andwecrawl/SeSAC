//
//  JoinViewController.swift
//  SACdyBuddy
//
//  Created by yeoni on 2023/11/09.
//

import UIKit
import RxSwift
import RxCocoa

enum VCType: String {
    case email = "이메일을 입력해 주세요."
    case password = "비밀번호를 입력해 주세요."
    case nickname = "이름을 입력해 주세요."
}

class JoinViewController: BaseViewController {
    
    let informationLabel = {
        let label = UILabel()
        label.text = "이메일을 입력해 주세요."
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        return label
    }()
    
    let descriptionLabel = {
        let label = UILabel()
        label.text = "왠지 무서운 오픈라운지 대신\n간편하게 만나요!"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .systemGray2
        return label
    }()
    
    let nextButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemGreen
        config.title = "시작하기"
        button.configuration = config
        return button
    }()
    
    let disposeBag = DisposeBag()
    
    var VCType: VCType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            informationLabel,
            descriptionLabel,
            nextButton
        ]
            .forEach({ view.addSubview($0) })
        
    }
    
    override func setConstraints() {
        
        informationLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(80)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(informationLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(informationLabel)
        }
        
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(52)
        }
        
    }
    
    override func configureView() {
        
        informationLabel.text = VCType?.rawValue
        
    }
    
    func bind() {
        
        nextButton.rx.tap
            .bind { _ in
                let vc = JoinViewController()
                vc.VCType = .email
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
    }
    
    
}
