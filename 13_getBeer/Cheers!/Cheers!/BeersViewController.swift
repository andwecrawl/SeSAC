//
//  ViewController.swift
//  Cheers!
//
//  Created by yeoni on 2023/09/20.
//

import UIKit

final class BeersViewController: UIViewController {

    let viewModel = BeerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        viewModel.request(api: .beers)
    }


}

