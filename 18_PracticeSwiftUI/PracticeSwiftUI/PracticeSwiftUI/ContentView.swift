//
//  ContentView.swift
//  PracticeSwiftUI
//
//  Created by yeoni on 2023/11/14.
//

import SwiftUI

struct ContentView: View {
    
    let previewButtonWidth = (UIScreen.main.bounds.width - 10) / 3.2
    
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Image("펀치 드렁크 러브")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: 700)
                Spacer()
            }
            .ignoresSafeArea()
            VStack {
                Image("background")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: 700)
                Spacer()
                
            }
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        print("welcome!")
                    }, label: {
                        Text("N")
                            .bold()
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    })
                    .padding(20)
                    
                    Spacer()
                    
                    Button(action: {
                        print("TV")
                    }, label: {
                        Text("TV 프로그램")
                            .bold()
                            .foregroundStyle(.white)
                    })
                    
                    Spacer()
                    Button(action: {
                        print("movie")
                    }, label: {
                        Text("영화")
                            .bold()
                            .foregroundStyle(.white)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        print("내찜콘")
                    }, label: {
                        Text("내가 찜한 콘텐츠")
                            .bold()
                            .foregroundStyle(.white)
                    })
                    Spacer()
                }
                
                Spacer()
                HStack {
                    
                    Button(action: {
                        print("찜")
                    }, label: {
                        VStack {
                            Image(systemName: "checkmark")
                                .imageScale(.large)
                                .padding(2)
                            Text("내가 찜한 콘텐츠")
                        }
                        .foregroundStyle(.white)
                    })
                    .padding()
                    
                    Button(action: {
                        
                    }, label: {
                        Image("play_normal")
                    })
                    .padding(30)
                    
                    Button(action: {
                        print("정보는 준비 중이에용")
                    }, label: {
                        VStack {
                            Image("info")
                                .padding(2)
                            Text("정보")
                                .foregroundStyle(.white)
                        }
                    })
                    .padding(30)
                }
                .padding()
                
                Text("미리보기")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .bold()
                    .foregroundStyle(.white)
                HStack {
                    Image("타오르는 여인의 초상")
                        .resizable()
                        .scaledToFill()
                        .frame(width: previewButtonWidth, height:  UIScreen.main.bounds.width / 3)
                        .clipShape(.circle)
                        .overlay(Circle().stroke(.gray, lineWidth: 5))
                    
                    Image("월레스와 그로밋 - 양털 도둑")
                        .resizable()
                        .scaledToFill()
                        .frame(width: previewButtonWidth, height:  previewButtonWidth)
                        .clipShape(.circle)
                        .overlay(Circle().stroke(.gray, lineWidth: 5))
                    
                    Image("캐롤")
                        .resizable()
                        .scaledToFill()
                        .frame(width: previewButtonWidth, height:  previewButtonWidth)
                        .clipShape(.circle)
                        .overlay(Circle().stroke(.gray, lineWidth: 5))
                }
                .padding(2)
                
            }
        }
        
        .frame(width: UIScreen.main.bounds.width)
    }
}

#Preview {
    ContentView()
}
