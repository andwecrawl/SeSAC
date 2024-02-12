//: [Previous](@previous)

import UIKit

protocol JackTableViewProtocol {
    func numberOfRowsInSections() -> Int
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell
}

//class vc: UIViewController, JackTableViewProtocol {
//
//}

@objc
protocol ViewPresentableProtocol {
    
    // 최소 요구 사항으로, get 만 할 수도 있고 set도 할 수 있음
    // 최소한 get은 디폴트!!!! 추가로 값 넣는 거 원하면 set도 ^ ^
    // 변수명만 같으면 상관없이, 프로토콜을 채택한 이후에 저장 프로퍼티로 구현해도 되고 연산 프로퍼티로 구현해도 댐
    //선택적 옵션(Optional Requirement) : 구현 객체에 따라 필요하지 않은 요소가 존재할 수 있어서, 이를 방지하기 위해 옵셔널 형태로 지정할 수 있음, 클래스에서만!!
    var navigationTitle: String { get set }
    var backgroundColor: UIColor { get }
    var identifier: String { get }
    
    func configureView()
    func configureLabel()
    @objc optional func configureTextField()
    // class밖에 안 댐
    // 이유: objc에는 Class밖에 없었기땜엥
}

// 명세만 되어 있고 단순한 선언 형태로 구성되어 있어서, 구체적인 내용은 별도로 구현이 이루어짐
// 특정 명세를 따르는 타입(클래스, 구조체 등)은 '프로토콜을 준수한다'라고 표현함
// 실질적인 구현(내용)은 클래스, 열거형, 구조체 등에서 이루어짐
//class A: UIViewController, ViewPresentableProtocol {
//    var navigationTitle: String = "검색 화면"
//
//    var backgroundColor: UIColor = .black
//
//    var identifier: String = "SearchingView"
//
//    func configureView() {
//        <#code#>
//    }
//
//    func configureLabel() {
//        <#code#>
//    }
//
//    func configureTextField() {
//        <#code#>
//    }
//
//
//}
//
//
//class B: UIViewController, ViewPresentableProtocol {
//    var navigationTitle: String {
//        get {
//            return "키티 일기장"
//        }
//        set {
//            return "wwk="
//        }
//
//    }
//
//    var backgroundColor: UIColor {
//        return .systemPink
//    }
//
//    var identifier: String {
//        return "kittyDiary"
//    }
//
//    func configureView() {
//        <#code#>
//    }
//
//    func configureLabel() {
//        <#code#>
//    }
//
//    func configureTextField() {
//        <#code#>
//    }
//
//
//}
//
//
//class C: UIViewController, ViewPresentableProtocol {
//    var navigationTitle: String
//
//    var backgroundColor: UIColor
//
//    var identifier: String
//
//    func configureView() {
//        <#code#>
//    }
//
//    func configureLabel() {
//        <#code#>
//    }
//
//    func configureTextField() {
//        <#code#>
//    }
//
//
//}
//: [Next](@next)
