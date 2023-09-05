//
//  FileManager+.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/09/05.
//

import UIKit

extension UIViewController {
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        // 1. document 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // 2. 경로 설정
        
        // 3. 이미지 변환
        
        // 4. 이미지 저장
        
    }
}
