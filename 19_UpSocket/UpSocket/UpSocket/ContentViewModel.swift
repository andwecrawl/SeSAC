//
//  ContentViewModel.swift
//  UpSocket
//
//  Created by yeoni on 12/27/23.
//

import Foundation

class ContentViewModel {
    
    @Published var marketList: [MarketModel]
    @Published var marketList: [MarketName]
    
    init(marketList: [MarketModel]) {
        self.marketList = marketList
    init() {
        self.marketList = []
        fetchMarketName()
    }
    
    func fetchMarketName() {
        NetworkManager.shared.fetchData(api: .marketName, type: [MarketName].self) { response in
            switch response {
            case .success(let value):
                print(value)
                self.marketList = value
            case .failure(let error):
                print(error)
            }
        }
    }
    
    }
    
    
    
}

