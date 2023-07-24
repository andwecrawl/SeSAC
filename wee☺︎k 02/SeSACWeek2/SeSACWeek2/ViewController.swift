//
//  ViewController.swift
//  SeSACWeek2
//
//  Created by yeoni on 2023/07/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var firstImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstImageView.isUserInteractionEnabled = true
        print(firstImageView.isUserInteractionEnabled)
        print(view.isUserInteractionEnabled)
        
    }

    
    @IBAction func imageViewTapped(_ sender: UITapGestureRecognizer) {
        print("image")
    }
    
    
    @IBAction func entireViewTapped(_ sender: UITapGestureRecognizer) {
        print("total")
    }
    
    
    

}

