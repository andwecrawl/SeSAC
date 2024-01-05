//
//  TabView.swift
//  UpSocket
//
//  Created by yeoni on 1/4/24.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Image(systemName: "bitcoinsign.circle")
                    Text("Hello")
                }
            LoginView()
                .tabItem{
                    Image(systemName: "gearshape.fill")
                    Text("Login")
                }
        }
        .tint(.mainYellow)
    }
}

#Preview {
    TabBarView()
}
