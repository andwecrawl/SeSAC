//
//  ViewController.swift
//  SeSACWeek2
//
//  Created by yeoni on 2023/07/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
    let list = ["가사1", "가사2", "가사3"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstImageView.isUserInteractionEnabled = true
        print(firstImageView.isUserInteractionEnabled)
        print(view.isUserInteractionEnabled)
        
    }

    @IBAction func playButtonClicked(_ sender: UIButton) {
        
        // 졸 .. 졸려잇
        print(sender.tag)
        
        
        
    }
    
    
    
    
    @IBAction func imageViewTapped(_ sender: UITapGestureRecognizer) {
        print("image")
    }
    
    
    // 바탕을 탭했을 때 이미지 뷰가 사라지도록!
    // StackView의 특성으로 가능!
    @IBAction func entireViewTapped(_ sender: UITapGestureRecognizer) {
        
        // 1.
        // firstImageView.isHidden = true
        
        print("제스쳐 전", firstImageView.isHidden)
        
        // 2.
//        if firstImageView.isHidden {
//            firstImageView.isHidden = false
//        } else {
//            firstImageView.isHidden = true
//        }
//
        print("제스쳐 후", firstImageView.isHidden)
        
        // 3.
        // firstImageView.isHidden = !firstImageView.isHidden
        // ! : not 연산자
        
        // 4.
        // firstImageView.isHidden.toggle()
        
        
        // 5.
        firstImageView.isHidden = firstImageView.isHidden ? false : true
        
        
    }
    
    
    

}

