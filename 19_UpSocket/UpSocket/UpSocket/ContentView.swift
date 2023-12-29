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

struct coinCell: View {
    @State var coinName: String
    @State var coinEngName: String
    @State var comparsion: String
    @State var cost: String
    @State var payment: String
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(coinName)
                    .font(.subheadline.bold())
                Text(coinEngName)
                    .font(.caption)
            }
            .padding()
            Group {
                Text("현재가")
                Text("전일대비")
                Text("거래 대금")
            }
            .padding(10)
            .font(.subheadline)
        }
    }
}
