//
//  ContentView.swift
//  UpSocket
//
//  Created by yeoni on 12/27/23.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
         ㄹ
                coinCell(coinName: "코인이름", coinEngName: "코인이름", comparsion: "현재가", cost: "전일대비", payment: "거래대금")
                
            }
            .padding()
            .navigationTitle("upsockets")
        }
    }
}

#Preview {
    ContentView()
}

struct CoinCell: View {
    @State var coinName: String
    @State var coinEngName: String
    @State var tradePrice: String // 현재가
    @State var change: String // 전일대비
    @State var accTradePrice: String // 거래대금
    
    var body: some View {
        HStack(alignment: .center) {
            LazyVStack(alignment: .leading) {
                Text(coinName)
                    .font(.subheadline.bold())
                Text(coinEngName)
                    .font(.caption)
            }
            .padding()
            Group {
                Text(tradePrice)
                Text(change)
                Text(accTradePrice)
            }
            .padding(.horizontal, 14)
            .font(.footnote)
        }
        .frame(width: .infinity, height: 36)
    }
}

struct ExchangeHeader: View {
    var body: some View {
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
                    .padding(.trailing, 3)
            }
        }
        .font(.footnote.bold())
        .padding(.horizontal, 2)
        .frame(width: .infinity, height: 30)
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
        .frame(minWidth: 40)
    }
}
