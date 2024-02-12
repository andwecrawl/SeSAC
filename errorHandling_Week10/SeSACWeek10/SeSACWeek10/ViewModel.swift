//
//  ViewModel.swift
//  SeSACWeek10
//
//  Created by yeoni on 2023/09/20.
//

import Foundation

final class ViewModel {
    
    
    func request(completionHandler: @escaping (URL) -> Void) {
        Network.shared.requestConvertible(type: PhotoResult.self, api: .random) { response in
            switch response {
            case .success(let success):
                dump(success)
                let url = URL(string: success.urls.thumb)!
                completionHandler(url)
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
    
    
    
}
