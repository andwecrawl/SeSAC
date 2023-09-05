//
//  FileManager+.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/09/05.
//

import UIKit
import RealmSwift

class FileManagerHelper {
    
    static let shared = FileManagerHelper()
    
    private init() { }
    
    enum Status {
        case save, load, remove
    }
    
    func doSomethingToDocument(status: Status, id: ObjectId, image: UIImage?, completionHandler: @escaping (UIImage?) -> ()) {
        let fileName = "user_\(id).jpg"
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        switch status {
        case .save:
            guard let image else { return }
            guard let data = image.jpegData(compressionQuality: 0.3) else { return }

            do {
                try data.write(to: fileURL)
            } catch {
                completionHandler(nil)
            }
            
        case .load:
            if FileManager.default.fileExists(atPath: fileURL.path) {
                let image = UIImage(contentsOfFile: fileURL.path)
                completionHandler(image)
            } else {
                completionHandler(UIImage(named: "noImage"))
            }
            
        case .remove:
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch {
                completionHandler(nil)
            }
        }
    }
}
