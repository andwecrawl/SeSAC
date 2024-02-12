//
//  FileManager+Extension.swift
//  PhotoGramRealm
//
//  Created by yeoni on 2023/09/05.
//

import UIKit

extension UIViewController {
    
//    func appendingPathComponent(
    
    func documentDirectoryPath() -> URL? {
        // 1. 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDirectory
    }
    
    func removeImageFromDocument(fileName: String) {
        // 1. 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // 2. 경로 설정(세부 경로, 이미지가 저장되어 있는 위치!!)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        // do-try-catch문으로 경로에 있는 파일을 지워주려고 함
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print(error)
        }
        
    }
    
    
    // 도큐먼트 폴더에서 이미지를 가지고 오는 method
    func loadImageFromDocument(fileName: String) -> UIImage {
        // 1. 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            // 경로에 없다! 하면 대체 이미지를 넣어줘도 ㄱㅊ
            return UIImage(systemName: "star.fill")!
        }
        
        // 2. 경로 설정(세부 경로, 이미지가 저장되어 있는 위치!!)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        // 3.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)!
        } else {
            return UIImage(systemName: "star.fill")!
        }
        
        
    }
    
    
    // document 폴더에 이미지를 저장하는 method
    func saveImageToDocument(fileName: String, image: UIImage) {
        
        // 1. 도큐먼트 경로 찾기
        guard let documentDIrectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        // 파일매니저에 싱글톤으로 접근해서 userData를 가져오게 되는데~
        // 이걸 가져오게 되면 파일부터 도쿠먼트 경로까지가 나오게 댐
        // 너히한테 내가~ 대략적인 (그때끄 바뀌는) 경로를 알려주께
        
        // 2. 저장할 경로 설정(세부 경로, 이미지 저장할 위치)
        // 경로를 먼저 만들고 이미지를 넣게 됨!!
        let fileURL = documentDIrectory.appendingPathComponent(fileName)
        
        // 3. 이미지 변환
        // compressionQuality: 압축률!!
        // 원본 데이터가 클 경우 압축률을 줄이는 것도 추천~~!
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        // 4. 이미지 저장
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }
}
