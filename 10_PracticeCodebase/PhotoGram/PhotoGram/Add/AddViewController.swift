//
//  ViewController.swift
//  PhotoGram
//
//  Created by yeoni on 2023/08/28.
//

import UIKit
import SeSACFramework
import PhotosUI

// protocol delegate를 활용한 값 전달
    // 1. 형태 맹글기
protocol PassDataDelegate {
    func receiveDate(date: Date)
}

protocol PassImageDelegate {
    func receiveData(Image: UIImage)
}

// 컨벤션을 생각하면 메인 뷰 / 디테일 뷰라는 이름은 지양하는 게 좋음
// 왜냐면 추후 메인 뷰가 바뀔 수도 있고 디테일 뷰가 바뀔 수도 있기에!!
class AddViewController: BaseViewController {
    // 기능... 에 조금 더 초점이 맞춰져 있었으면 좋겠음
    // 뷰를 그려준다거나 뷰를 컨트롤해준다거나 뷰를 옮겨준다거나 하는 것 같은!!
    // 지금은 너무 뷰를 그리는 데 초점이 맞춰져 있지 않나???
    
    let mainView = AddView()
    
    
    override func loadView() { // viewDidLoad보다 먼저 생성됨
        // 보통 뷰는 이때 싹 다 호출됨!!
        // 주의 사항!!!!!!!! superMethod 호출하면 안댐!!!!!!
        // 사유: 애플이 기존에 가지고 있던 view가 아니라 customView를 사용하는 거라
        // 만약에 superMethod를 호출하게 되면 호출할 커스텀뷰가 보여지는 것이 아니라 애플이 기존에 설정했던 뷰가 설정될 수 있음
        
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        APIService.shared.callRequest(query: "sky") { <#Photo?#> in
//            <#code#>
//        }
        
        //        ClassOpenExamle.publicExample()
        //        ClassPublicExample.publicExample()
        //        // internal이라서 접근할 수 없어~~
        //        ClassInternalExample.internalExample()
        
        
    }
    
    // 메모리에서 해제되는 시점을 탐지해 주는 거임!!
    deinit {
        print("deinit", self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 나 신호 받을게!!
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: .selectImage, object: nil)
        // selector / name만 중요
        // name은 내가 데이터를 가져올 변수 ㅇㅇ
        // addObserver랑 post 신호를 받는 순서가 중요하다
        // 먼저 addObserver -> Post!! 해야 제대로 들어간다
        
//        sesacShowActivityViewController(image: UIImage(systemName: "star")!, url: "url", text: "text")
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .selectImage, object: nil)
    }
    
    @objc func searchButtonClicked() {
//        present(SearchViewController(), animated: true)
       let vc = SearchViewController()
        vc.delegate = self
        // addObserver보다 post가 먼저 들어가면 실행이 안 댐!!
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        // 이때의 userInfo ... 는
        // NotificationCenter.default.post(name: NSNotification.Name("selectImage"), object: nil, userInfo: ["name": imageList[indexPath.item], "sample": "hello"]) 안의 userInfo
        
        print(#function)
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
        
    }
    
    // 자동 완성을 통해서 불러올 수 있다는 점에서 나중에 코드에서 자동완성을 쉽게 할 수 있어서 좋음!!
    override func configureView() { // addSubview
        // 부모클래스의 method도 실행시켜 주고 싶다!! 한다면 superClass를 호출해 주어야 함
        super.configureView()
        
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        mainView.searchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonClicked), for: .touchUpInside)
        mainView.titleButton.addTarget(self, action: #selector(titleButtonClicked), for: .touchUpInside)
        mainView.contentButton.addTarget(self, action: #selector(contentButtonClicked), for: .touchUpInside)

    }
    
    @objc func contentButtonClicked() {
        let vc = DiaryViewController()
        
        vc.completionHandler = { text, num, bool in
            self.mainView.contentButton.setTitle(text, for: .normal)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func titleButtonClicked() {
        let vc = TitleViewController()
        
        // Closure 값 전달 3.
        vc.completionHandler = { str in
            self.mainView.titleButton.setTitle(str, for: .normal)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchProtocolButtonClicked() {
//        let vc = SearchViewController()
//        vc.delegate = self
        // delegate 친구 너 잇지...
        // 내가 대신 실행하겟다구 알려줄래?!
        // => searchVC에서의 delegate는 연결만 해 주고 실제 실행은 addVC에서 하게 댐
        
        giveAlert()
//        present(vc, animated: true)
    }
    
    @objc func dateButtonClicked() {
        // protocol 값 전달 5.
            // 넘겨줄 때 delegate에 대한 연결을 해줌!!
//        let vc = DateViewController()
//        vc.delegate = self
//        navigationController?.pushViewController(vc, animated: true)
        
        let vc = HomeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func setConstraints() { // 제약조건
        super.setConstraints()
    }
    
    
    func giveAlert() {
        let alert = UIAlertController(title: "기록에 넣을 사진이 필요해요!", message: "사진을 가져올 방법을 선택해 주세요.", preferredStyle: .actionSheet)
        let gallery = UIAlertAction(title: "갤러리에서 가져오기", style: .default) { _ in
            // 갤러리 함수
            var config = PHPickerConfiguration()
            config.selectionLimit = 1
            config.filter = .images
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
            self.present(picker, animated: true)
            
        }
        let search = UIAlertAction(title: "웹에서 검색하기", style: .default) { _ in
            let vc = SearchViewController()
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(gallery)
        alert.addAction(search)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}


// 프로토콜 값 전달 4.
    // delegate를 가지고 있는 건 dateVC이지만 실질적으로 일은 여기서 수행함!!
extension AddViewController: PassDataDelegate {
    
    func receiveDate(date: Date) {
        mainView.dateButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }
}

extension AddViewController: PassImageDelegate {
    
    func receiveData(Image: UIImage) {
        DispatchQueue.main.async {
            self.mainView.photoImageView.image = Image
        }
    }
    
}

extension AddViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        // 이미지 클릭 시 화면 dismiss
        picker.dismiss(animated: true)
        
        // itemProvider == 선택한 asset을 보여주는 역할을 함!!
        if let itemProvider = results.first?.itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            let type: NSItemProviderReading.Type = UIImage.self
            itemProvider.loadObject(ofClass: type) { image, error in
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        self.mainView.photoImageView.image = image
                    }
                } else {
                    print(error)
                }
            }
        }
    }
}
