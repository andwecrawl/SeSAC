//
//  ViewController.swift
//  SeSACWeek10
//
//  Created by yeoni on 2023/09/19.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    
    private let scrollView = {
        let view = UIScrollView()
        view.backgroundColor = .green
        view.minimumZoomScale = 1
        // 보통 3~5 정도로 준다구 함
        view.maximumZoomScale = 5
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private let imageVIew = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .red
        view.contentMode = .scaleToFill
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        
        configureGesture()
        
        viewModel.request { url in
            self.imageVIew.kf.setImage(with: url)
            
        }
        
        /*
        Network.shared.request(type: Photo.self, api: .search(query: "hi")) { response in
            switch response {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
        
        Network.shared.request(type: Photo.self, api: .search(query: "hello")) { response in
            switch response {
            case .success(let success):
                <#code#>
            case .failure(let failure):
                <#code#>
            }
        }
         */
    }
    
    func configureGesture() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture))
        tap.numberOfTapsRequired = 2
        imageVIew.addGestureRecognizer(tap)
    }
    
    @objc func doubleTapGesture() {
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(2, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    
    func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageVIew)
        
        scrollView.delegate = self
    }
    
    
    func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.size.equalTo(250)
            make.center.equalTo(view)
        }
        
        imageVIew.snp.makeConstraints { make in
            make.size.equalTo(scrollView)
        }
    }
    
    
    /*
    func lastRequest() {
        // 이전까지 구성했던 completionHandler
        NetworkBasic.shared.random { photo, error in
            if let error { // error
                
            } else { // 값이 있는 경우!!
                
            }
        }
        
        // 새로 리팩토링한 completionHandler
        NetworkBasic.shared.detailPhoto(id: "") { response in
            switch response {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
     */
    
}

extension ViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageVIew
    }
    
    
    
}





// Codable: Decodable + Encodable
struct Photo: Decodable, Hashable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable, Hashable {
    let id: String
    let created_at: String
    let urls: PhotoURL
    let width: CGFloat
    let height: CGFloat
}

struct PhotoURL: Decodable, Hashable {
    let full: String
    let thumb: String
}
