//
//  DetailView.swift
//  UpSocket
//
//  Created by yeoni on 1/6/24.
//

import SwiftUI

struct DetailView: View {
    @StateObject
    var viewModel: DetailViewModel
    
    @State var selectedIndex = 0
    let titles = ["주문", "호가", "차트", "시세", "정보"]
    
    var body: some View {
        var coinName = viewModel.coin.korName + "(\(viewModel.coin.marketCode))"
        NavigationStack {
            VStack {
                DetailBannerView(coin: viewModel.coin)
                SegmentedControlView(selectedIndex: $selectedIndex, titles: titles)
                    .animation(.default, value: selectedIndex)
                    .frame(maxWidth: .infinity)
                
                switch selectedIndex {
                case 0:
                    WaitingView()
                default:
                    WaitingView()
                }
                Spacer()
            }
        }
        .navigationTitle(viewModel.coin.korName + "(\(viewModel.coin.marketCode))")
    }
}
