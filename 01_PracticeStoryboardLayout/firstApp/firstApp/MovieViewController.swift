//
//  MovieViewController.swift
//  firstApp
//
//  Created by yeoni on 2023/07/19.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet var thirdImageView: UIImageView!
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var playButton: UIButton!
    
    // 사용자에게 화면이 보이기 직전에 실행되는 부분
    // 모서리 둥글기, 그림자 등 스토리보드에서 설정할 수 없는 UI를 설정할 때 주로 사용
    // 뷰컨트롤러 생명주기
    // 화면이 뜨는 시점을 알려주는 거임
    
    let images: [String] = [ "1", "2", "3", "4", "5", "극한직업", "도둑들", "명량", "베테랑", "부산행", "신과함께인과연", "신과함께죄와벌", "알라딘", "암살", "아바타"]
    let random = [1, 2, 3, 4, 5]
    let borderColor: [CGColor] = [
        UIColor.red.cgColor,
        UIColor.cyan.cgColor,
        UIColor.blue.cgColor,
        UIColor.yellow.cgColor,
        UIColor.gray.cgColor,
        UIColor.green.cgColor,
        UIColor.systemTeal.cgColor,
        UIColor.systemIndigo.cgColor,
        UIColor.systemMint.cgColor,
        UIColor.orange.cgColor,
        UIColor.magenta.cgColor,
        UIColor.brown.cgColor,
        UIColor.systemPink.cgColor,
        UIColor.purple.cgColor
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageViewBundle: [UIImageView] = [mainImageView, firstImageView, secondImageView, thirdImageView]
        
        showRandomMovie(imageViewBundle: imageViewBundle)
        posterOutletSettings(imageViewBundle: imageViewBundle)
       
    }
    
    
    // 공사 중 트리오
    @IBAction func programButtonTapped(_ sender: UIButton) {
        underConstruction()
    }
    
    @IBAction func movieButtonTapped(_ sender: UIButton) {
        underConstruction()
    }
    
    @IBAction func likedButtonTapped(_ sender: UIButton) {
        underConstruction()
    }
    
    
    // 재생 버튼이 눌렸을 때
    @IBAction func PlayButtonPushed(_ sender: UIButton) {
        let normal = UIImage(named: "play_normal")
        let highlighted = UIImage(named: "play_highlighted")
        playButton.setImage(normal, for: .normal)
        playButton.setImage(highlighted, for: .highlighted)
        
        let imageViewBundle: [UIImageView] = [mainImageView, firstImageView, secondImageView, thirdImageView]
        
        showRandomMovie(imageViewBundle: imageViewBundle)
        
    }
    
    
    func showRandomMovie(imageViewBundle: [UIImageView]) {
        for imageView in imageViewBundle {
            let randomResult =   images.randomElement() ?? "3"
            imageView.image = UIImage(named: "\(randomResult)")
            if imageView == mainImageView {
                continue
            } else {
                imageView.layer.borderColor = borderColor.randomElement()!
            }
        }
    }
    
    
    // outletName: 외부 매개변수(Argument Label), 내부 매개변수(Parameter Name)
    // 매개변수: Parameter - 전달인자를 받을 변수
    // 전달인자: Argument - 함수를 호출할 때 전달하는 값 (시시각각 변동)
    func posterOutletSettings(imageViewBundle: [UIImageView]) {
        for element in imageViewBundle {
            element.layer.cornerRadius = 60
            element.layer.borderWidth = 5
            element.backgroundColor = .blue
            element.contentMode = UIView.ContentMode.scaleAspectFill
        }
    }
    
    // 기본 버튼 디자인 셋팅
    func designButton() {
        playButton.layer.cornerRadius = 10
        playButton.layer.cornerRadius = 0
        playButton.layer.borderColor = UIColor.red.cgColor
        playButton.layer.borderWidth = 4
    }
    
    func underConstruction() {
        let alert = UIAlertController(title: "공사 중입니다.", message: "다음에 다시 찾아주세요!", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel)
        let accpet = UIAlertAction(title: "accept", style: .default)
        
        alert.addAction(cancel)
        alert.addAction(accpet)
        
        present(alert, animated: true)
    }
}
