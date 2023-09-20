//
//  BeersViewModel.swift
//  Cheers!
//
//  Created by yeoni on 2023/09/20.
//

import Foundation

class BeerViewModel {
    
    func request(api: Router) {
        Network.shared.request(type: Beer.self, api: api) { response in
            switch response {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
