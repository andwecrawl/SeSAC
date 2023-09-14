//
//  MapViewController.swift
//  PhotoGram
//
//  Created by yeoni on 2023/08/29.
//

import UIKit
import WebKit

// :3c
class WebViewController: UIViewController, WKUIDelegate {
    
    // 선언이랑 초기화!! 가 중요함
    // 왜 nil이 나올까? 보통 선언이 이상하게 대어잇을때 글치 않나~~
    var webView = WKWebView()
    
    
    // 이전에는 바로 타입에 대한 선언을 하고 넣어줬음
//    var webView: WKWebView!
    
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 엥
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        // 네비게이션 컨트롤러가 처음에 투명, 스크롤하면 불투명하게 맹글고 싶음!!
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .red
        
        // standard => 스크롤 시 bgColor 적용!!
        navigationController?.navigationBar.standardAppearance = appearance
        
        // 투명도에 따라서 safeArea나 스크롤 시 적용되는 속성이 달라질 수 있음!!
        // 투명도 속성은 rootView의 크기 정도가? 달라진다고 보면 댐
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        // 탭바에도 edge가 있음!! standard / edge appearance는
        // 탭바에도 동일하게 적용된당
    }
    
    func reloadButtonClicked() {
        // 새로고침 기능... ^ ^
        webView.reload()
    }
    
    func goBackButtonClicked() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            // 버튼 비활성화~~
        }
    }
    
    func goForwardButtonClicked() {
        if webView.canGoForward {
            webView.goForward()
        } else {
            // 버튼 비활성화~~
        }
    }
}
