//
//  WormDetailViewController.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/09/05.
//

import UIKit
import SnapKit

class WormDetailViewController: UIViewController {
    
    var book: BookTable?
    
    private let contentScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    let contentView = UIView()
    
    let backImageView = UIImageView.imageBuilder()
    
    let blur = {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        return visualEffectView
    }()
    
    let thumbImageView = UIImageView.imageBuilder()
    
    let descriptionView = UIView()
    let titleLabel = UILabel.labelBuilder(size: 18, weight: .bold)
    let descriptionLabel = UILabel.labelBuilder(size: 15, weight: .medium)
    let overviewLabel = UILabel.labelBuilder(size: 15, weight: .light)
    
    let stackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        view.alignment = .leading
        view.distribution = .equalSpacing
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setConstraints()
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentView)
        
        contentView.addSubview(stackView)
        descriptionView.addSubview(backImageView)
        backImageView.addSubview(blur)
        contentView.addSubview(thumbImageView)
        
        stackView.addArrangedSubview(descriptionView)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(overviewLabel)
        contentView.addSubview(stackView)
        let text = "가나다라마바사아자차카타파하"
        titleLabel.text = text
        descriptionLabel.text = text
        overviewLabel.text = text + text + text + text
    }
    
    func setConstraints() {
        contentScrollView.backgroundColor = .yellow
        contentView.backgroundColor = .red
        contentScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(view)
//            make.centerX.top.bottom.equalTo()
        }
//        contentView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor).isActive = true
       
        backImageView.image = UIImage(named: "캐롤")
        backImageView.contentMode = .scaleToFill
        blur.snp.makeConstraints { make in
            make.edges.equalTo(backImageView)
        }
        backImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(backImageView.snp.width).multipliedBy(0.7)
        }
        
        thumbImageView.image = UIImage(named: "양들의 침묵")
        thumbImageView.backgroundColor = .black
        thumbImageView.snp.makeConstraints { make in
            make.centerX.equalTo(backImageView)
            make.centerY.equalTo(backImageView)
            make.width.equalTo(100)
            make.height.equalTo(thumbImageView.snp.height).multipliedBy(1.3)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(thumbImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
    }
    
    
}
