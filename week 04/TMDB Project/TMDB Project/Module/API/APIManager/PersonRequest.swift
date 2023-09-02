//
//  PersonRequest.swift
//  TMDB Project
//
//  Created by yeoni on 2023/09/03.
//

import Foundation

extension TMDBManager {
    func callPersonRequest(completionHandler: @escaping (Person?) -> Void) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/person/day?language=en-US") else { return }
        var request = URLRequest(url: url, timeoutInterval: 5)
        request.headers = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completionHandler(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                completionHandler(nil)
                return
            }
            
            guard let data = data else {
                completionHandler(nil)
                return
            }
            do {
                let result = try JSONDecoder().decode(Person.self, from: data)
                completionHandler(result)
                print(result)
            } catch {
                completionHandler(nil)
            }
        }
    }
}
