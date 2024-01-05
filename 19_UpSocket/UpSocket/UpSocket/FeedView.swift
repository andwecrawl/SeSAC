//
//  ContentView.swift
//  UpSocket
//
//  Created by yeoni on 12/27/23.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject
    private var viewModel = ContentViewModel()
    @State var searchQueryString = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        ForEach(viewModel.coinList, id: \.id) { item in
                            CoinCell(coin: item)
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                        }
                    } header: {
                        ExchangeHeader()
                            .frame(maxWidth: .infinity)
//                            .frame(height: 30)
                    }
                }
                .searchable(
                    text: $searchQueryString,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "코인명/심볼을 검색해 보세요!"
                )
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Upsockets")
            }
            .clipped()
            
        }
        
    }
}

#Preview {
    FeedView()
}

struct CoinCell: View {
    @State var coin: CoinModel
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                LazyVStack(alignment: .leading) {
                    Text(coin.korName)
                        .font(.system(size: 13).bold())
                    Text(coin.engName)
                        .font(.caption)
                        .foregroundStyle(.trustGray)
                }
                .padding()
                Group {
                    Text(coin.tradePrice.toString())
                        .frame(width: 80, alignment: .trailing)
                    Text(coin.change.toString())
                        .frame(width: 80, alignment: .trailing)
                    Text(coin.accTradePrice.toFormattedString())
                        .frame(width: 80, alignment: .trailing)
                        .padding(.trailing, 8)
                }
                .padding(.horizontal, 7)
                .font(.footnote)
            }
            
            Rectangle()
                .fill(.yellow)
//                .fill(.gray.opacity(0.6))
//                .frame(maxWidth: .infinity)
        }
    }
}

struct ExchangeHeader: View {
    var body: some View {
        ZStack {
            Color(.white)
            VStack {
                HStack(alignment: .center) {
                    LazyVStack(alignment: .leading) {
                        HStack {
                            Text("코인 이름")
                            Image(systemName: "arrow.left.arrow.right")
                                .font(.caption2)
                        }
                    }
                    .frame(minWidth: 100)
                    .padding()
                    Group {
                        SubtitleView(name: "현재가")
                        SubtitleView(name: "전일대비")
                        SubtitleView(name: "거래대금")
                            .padding(.trailing, 10)
                    }
                    .padding(.trailing, 4)
                }
                .font(.footnote.bold())
                .frame(height: 20)
                
                Rectangle()
                    .fill(.black.opacity(0.6))
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
            }
            .padding(.top, 10)
        }
    }
}

struct SubtitleView: View {
    @State var name: String
    
    var body: some View {
        HStack {
            Text(name)
            Image(systemName: "arrow.up.arrow.down")
                .font(.caption2)
        }
        .frame(width: 80)
    }
}
