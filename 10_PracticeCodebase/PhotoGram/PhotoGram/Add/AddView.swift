//
//  AddView.swift
//  PhotoGram
//
//  Created by yeoni on 2023/08/28.
//

import UIKit

class AddView: BaseView {
    
    let photoImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleToFill
        return view
    }()
    
    let searchProtocolButton = {
        let view = UIButton()
        let image = UIImage(systemName: "line.horizontal.3")
        view.setImage(image, for: .normal)
        view.tintColor = .darkGray
        return view
    }()
    
    let searchButton = {
        let view = UIButton()
        let image = UIImage(systemName: "magnifyingglass")
        view.setImage(image, for: .normal)
        view.tintColor = .darkGray
        return view
    }()
    
    let dateButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        view.setTitle(DateFormatter.today(), for: .normal)
        return view
    }()
    
    let titleButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        view.setTitle("오늘의 사진", for: .normal)
        return view
    }()
    
    let contentButton = {
        let view = UIButton()
        view.backgroundColor = .systemGray3
        view.setTitle("오늘은 어떠셨나요?", for: .normal)
        return view
    }()
    
    override func configureView() {
        addSubview(photoImageView)
        addSubview(searchButton)
        addSubview(dateButton)
        addSubview(searchProtocolButton)
        addSubview(titleButton)
        addSubview(contentButton)
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.topMargin.leadingMargin.trailingMargin.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        searchButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.trailing.equalTo(photoImageView)
        }
        
        searchProtocolButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.leading.equalTo(photoImageView)
        }
        
        dateButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(photoImageView.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        
        titleButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(dateButton.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        
        contentButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(titleButton.snp.bottom).offset(10)
            make.height.equalTo(250)
        }
    }
}
