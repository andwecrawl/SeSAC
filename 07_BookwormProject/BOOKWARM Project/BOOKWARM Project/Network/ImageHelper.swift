//
//  ImageHelper.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/09/05.
//

import UIKit


extension APIHelper {
    func getImage(path: String, completionHandler: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: path) else { return }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    completionHandler(image)
                }
                
            } catch {
                print("Image error!")
                completionHandler(nil)
            }
        }
    }
}
