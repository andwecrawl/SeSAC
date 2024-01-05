//
//  CoinCell.swift
//  UpSocket
//
//  Created by yeoni on 1/6/24.
//

import SwiftUI

struct CoinCell: View {
    @State var coin: CoinModel
    
    var body: some View {
        HStack(alignment: .center) {
            LazyVStack(alignment: .leading) {
                Text(coin.korName)
                    .font(.system(size: 13).bold())
                Text(coin.engName)
                    .font(.caption)
                    .foregroundStyle(.gray.opacity(0.6))
            }
            .padding(.leading, 10)
            .padding(.trailing, 4)
            
            Group {
                Text(coin.tradePrice.toString())
                    .foregroundStyle(coin.change < 0 ? .blue : .red)
                    .font(.footnote)
                    .frame(width: 75, alignment: .trailing)
                VStack(alignment: .trailing) {
                    Text(coin.change.percentToString() + "%")
                        .font(.footnote)
                    Text(coin.changePrice.toString())
                        .font(.caption2)
                }
                .foregroundStyle(coin.change < 0 ? .blue : .red)
                .frame(width: 60, alignment: .trailing)
                Text(coin.accTradePrice.toFormattedString())
                    .font(.footnote)
                    .frame(width: 76, alignment: .trailing)
                    .padding(.trailing, 8)
            }
            .padding(.horizontal, 7)
        }
        .frame(height: 35)
    }
}
