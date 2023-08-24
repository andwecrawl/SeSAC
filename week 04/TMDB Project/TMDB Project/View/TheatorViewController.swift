//
//  TheatorViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/24.
//

import UIKit
// 위치 가져오기: 1. CoreLocation import
import CoreLocation
import MapKit
import SnapKit

class TheatorViewController: UIViewController {

    // 위치의 대부분을 담당하고 있는 위치 매니저 생성
    // 위치 가져오기: 2. LocationManager 생성
    let locationManager = CLLocationManager()
    
    let mapView = MKMapView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 위치 가져오기: 4. delegate 연결
        locationManager.delegate = self
        
    }
    
    
    func setupLayout() {
        
        
        
        
    }


}


// 위치 가져오기 3: 프로토콜 선언
extension TheatorViewController: CLLocationManagerDelegate {
    
    // 사용자에게 위치를 성공적으로 가져올 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // 37.517829, 126.886270
        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        let location = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        
        
    }
    
    
    // 위치가 잘 오지 않거나 위치 서비스에 다시 요청을 보내야 할 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
    
    
    
}




extension TheatorViewController: MKMapViewDelegate {
    
    
    
}
