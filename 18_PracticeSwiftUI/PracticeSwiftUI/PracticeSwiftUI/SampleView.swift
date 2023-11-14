//
//  SampleView.swift
//  PracticeSwiftUI
//
//  Created by yeoni on 2023/11/14.
//

import SwiftUI

struct SampleView: View {
        var body: some View {
            Text("hello?")
                .modifier(boldCapsuleText())
        }
}

#Preview {
    SampleView()
}

struct boldCapsuleText: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .bold()
            .padding()
            .foregroundStyle(.white)
            .background(.black)
            .clipShape(.capsule)
    }
    
}

extension View {
    func asBoldCapsuleText() -> some View {
        modifier(boldCapsuleText())
    }
}

struct CustomViewModifier: View {
    var body: some View {
        Text("행복한해파리")
            .asBoldCapsuleText()
    }
}
