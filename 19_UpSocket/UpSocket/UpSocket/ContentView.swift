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
            }
            .padding(10)
            .font(.subheadline)
        }
    }
}
