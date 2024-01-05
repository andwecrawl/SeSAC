//
//  ContentView.swift
//  UpSocket
//
//  Created by yeoni on 12/27/23.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject
    private var viewModel = FeedViewModel()
    @State var searchQueryString = ""
    var body: some View {
        
        NavigationStack {
            ScrollView {
                Image(.coin)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .frame(width: 40, height: 40)
                    .padding(.top, 4)
                SearchBarView(searchText: $searchQueryString)
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        ForEach(viewModel.coinList, id: \.id) { item in
                            CoinCell(coin: item)
                                .frame(maxWidth: .infinity)
                            Rectangle()
                                .fill(.trustGray.opacity(0.6))
                                .frame(height: 1)
                                .frame(maxWidth: 420)
                        }
                    } header: {
                        ExchangeHeader()
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .clipped()
            
        }
    }
}

#Preview {
    FeedView()
}
