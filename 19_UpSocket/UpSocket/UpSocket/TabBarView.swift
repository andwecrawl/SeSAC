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
                    Image(systemName: "person.crop.circle")
                    Text("Hello")
                }
            LoginView()
                .tabItem{
                    Image(systemName: "arrow.right.circle.fill")
                    Text("Login")
                }
        }
        .tint(.trustBlue)
    }
}

#Preview {
    TabBarView()
}
