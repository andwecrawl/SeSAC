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

class TheaterViewController: UIViewController {
    
    enum Status {
        case total
        case lotte
        case cgv
        case megabox
    }
    
    
    let theaterList = TheaterList().mapAnnotations
    
    // 위치의 대부분을 담당하고 있는 위치 매니저 생성
    // 위치 가져오기: 2. LocationManager 생성
    let locationManager = CLLocationManager()
    
    let mapView = MKMapView()
    let locationButton = UIButton.buttonBuilder(bgColor: .systemBlue, image: UIImage(systemName: "location.fill"))
    let theaterButton = UIButton.buttonBuilder(bgColor: .red, image: UIImage(systemName: "popcorn.fill"))
    
    var isFirst: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 위치 가져오기: 4. delegate 연결
        locationManager.delegate = self
        
        setupLayout()
        checkDeviceLocationAuthorization()
    }
    
    @objc func locationButtonTouched() {
        checkDeviceLocationAuthorization()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        mapView.removeAnnotations(mapView.annotations)
    }
    
    func setupLayout() {
        locationButton.addTarget(self, action: #selector(locationButtonTouched), for: .touchUpInside)
        theaterButton.menu = setupPop()
        
        view.addSubview(mapView)
        view.addSubview(locationButton)
        view.addSubview(theaterButton)
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        locationButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        theaterButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
    }
    
    // 사용자의 위치 권한을 check하는 method
    func checkDeviceLocationAuthorization() {
        
        DispatchQueue.global().async {
            
            if CLLocationManager.locationServicesEnabled() { // 요청이 켜져 있으면
                
                var authorization: CLAuthorizationStatus
                // 사용자의 권한 여부를 알 수 있음
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    checkCurrentLocationAuthorization(status: authorization)
                }
                
            } else { // 요청이 꺼져 있으면
                self.showRequestLocationServiceAlert()
            }
        }
        
        
        func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
            switch status {
            case .notDetermined:
                // 최초로 사용자가 앱을 켰을 때
                
                // 정확도 설정!
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                
                // Alert
                locationManager.requestWhenInUseAuthorization()
                // 이후 info.plist에서 Privacy - Location When In USe Authorization에 요청 메세지를 적어야 한다.
            case .restricted:
                print("restricted")
                showRequestLocationServiceAlert()
            case .denied:
                print("denied")
                showRequestLocationServiceAlert()
            case .authorizedAlways:
                print("authorizedAlways")
                locationManager.startUpdatingLocation()
            case .authorizedWhenInUse:
                print("authorizedWhenInUse")
                // didUpdateLocation 메서드 실행
                locationManager.startUpdatingLocation()
            case .authorized:
                print("authorized")
                locationManager.startUpdatingLocation()
            @unknown default:
                // 얘는 왜?
                // 추후 애플에서 추가할지 모를 CLAuthorizationStatus 값을 대비하는 거임!!
                // 그 표시로 @unknown이 붙음 ^_^
                // 아~ 다 구현하긴 했는데 혹시 더 추가될지 몰라서 넣은 거야~ 임
                print("default")
            }
        }
    }
    
    
    func setAnnotation(status: Status) {
        
        switch status {
        case .total:
            mapView.removeAnnotations(mapView.annotations)
            theaterList.forEach { theater in
                let annotation = MKPointAnnotation()
                annotation.title = theater.location
                annotation.coordinate = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
                mapView.addAnnotation(annotation)
            }
        case .lotte:
            mapView.removeAnnotations(mapView.annotations)
            theaterList.forEach { theater in
                let annotation = MKPointAnnotation()
                if theater.type == "롯데시네마" {
                    annotation.title = theater.location
                    annotation.coordinate = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
                    mapView.addAnnotation(annotation)
                }
            }
        case .cgv:
            mapView.removeAnnotations(mapView.annotations)
            theaterList.forEach { theater in
                let annotation = MKPointAnnotation()
                if theater.type == "CGV" {
                    annotation.title = theater.location
                    annotation.coordinate = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
                    mapView.addAnnotation(annotation)
                }
            }
        case .megabox:
            mapView.removeAnnotations(mapView.annotations)
            theaterList.forEach { theater in
                let annotation = MKPointAnnotation()
                if theater.type == "메가박스" {
                    annotation.title = theater.location
                    annotation.coordinate = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
                    mapView.addAnnotation(annotation)
                }
            }
        }
        
    }
    
    
    func setLocation(location: CLLocationCoordinate2D?) {
        
        // 37.517829, 126.886270
        let center = location ?? CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.title = "currentLocation!"
        annotation.coordinate = center
        mapView.addAnnotation(annotation)
    }
    
    func setFirstView() {
        let center = CLLocationCoordinate2D(latitude: 37.510858, longitude: 126.959930)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 20000, longitudinalMeters: 20000)
        mapView.setRegion(region, animated: true)
        isFirst = false
        
        setAnnotation(status: .total)
    }
}




// 위치 가져오기 3: 프로토콜 선언
extension TheaterViewController: CLLocationManagerDelegate {
   
    // 사용자에게 위치를 성공적으로 가져올 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            if isFirst {
                setFirstView()
            } else {
                setLocation(location: coordinate)
            }
        }
        
        locationManager.stopUpdatingLocation()
        
    }
    
    
    // 위치가 잘 오지 않거나 위치 서비스에 다시 요청을 보내야 할 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
    
    
    
    // 사용자의 권한 상태가 바뀌었을 때를 알려줌!!
    // 근데 명확한 권한 상태를 알려주는 게 아니라서 정확한 권한을 아는 건 다른 method에서 수행해야 함
    // iOS 14 이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 위치 권한 바뀌었을 때!! 어떻게 바뀌었는지 check해주는 method 실행해야 함
        checkDeviceLocationAuthorization()
    }
    
    
    // iOS 14 이하
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 위치 권한 바뀌었을 때!! 어떻게 바뀌었는지 check해주는 method 실행해야 함
        
    }
    
}




extension TheaterViewController: MKMapViewDelegate {
    
    
    
}



extension TheaterViewController {
    /*
     Location Authorization Custom Alert
     */
    
    // 앱의 위치 서비스 설정이 아예 켜져 있지 않은 경우 기본 설정을 켜주기 위한 method
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            // iOS 기본 설정 페이지로 바로 이동
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
    
    
    // popUpButtonBuilder
    func setupPop() -> UIMenu {
        lazy var menuItems: [UIAction] = [
            UIAction(title: "전체", handler: { _ in
                self.setAnnotation(status: .total)
            }),
            UIAction(title: "롯데시네마", handler: { _ in
                self.setAnnotation(status: .lotte)
            }),
            UIAction(title: "CGV", handler: { _ in
                self.setAnnotation(status: .cgv)
            }),
            UIAction(title: "메가박스", handler: { _ in
                self.setAnnotation(status: .megabox)
            })
        ]
        let menu = UIMenu(title: "", options: [], children: menuItems.reversed())
        return menu
    }
    
}
