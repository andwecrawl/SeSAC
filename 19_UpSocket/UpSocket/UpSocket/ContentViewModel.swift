//
//  ContentViewModel.swift
//  UpSocket
//
//  Created by yeoni on 12/27/23.
//

import Foundation

class ContentViewModel {
    
    @Published var marketList: [MarketModel]
    
    init(marketList: [MarketModel]) {
        self.marketList = marketList
    }
    
    
    
}

