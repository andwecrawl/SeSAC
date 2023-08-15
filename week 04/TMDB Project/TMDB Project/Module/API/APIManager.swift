//
//  APIManager.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/13.
//


import Foundation
import Alamofire
import SwiftyJSON

class TMDBManager {
    
    static var movieGenreList: [Int: String] = [:]
    static var tvGenreList: [Int: String] = [:]
    
    static let shared = TMDBManager()
    
    private init() { }
    
    let headers: HTTPHeaders = [
        "accept": "application/json",
        "Authorization": APIKey.auth.rawValue
    ]
    
    
    func callRequest(page: Int = 1, completionHandler: @escaping () -> ()) {
        
        let url = "https://api.themoviedb.org/3/trending/all/day?language=en-US&page=\(page)"
        AF.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for element in json["results"].arrayValue {
                    
                    let mediaType = element["media_type"].stringValue
                    let genreId: Int = element["genre_ids"][0].intValue
                    var genreStr: String = ""
                    if mediaType == Media.tv.rawValue {
                        // 해당 genreDictionary가 장르값을 가지고 있는지 확인
                        
                        if let genre = TMDBManager.tvGenreList[genreId] {
                            // 해당 genreDictionary가 장르값을 가지고 있으면 가지고 옴
                            genreStr = genre
                            let id = element["id"].intValue
                            let title = element["title"].stringValue
                            let date = element["release_date"].stringValue
                            let overview = element["overview"].stringValue
                            let backdropImage = element["backdrop_path"].stringValue
                            let posterImage = element["poster_path"].stringValue
                            
                            let newMedia = TrendMedia(id: id, title: title, mediaType: mediaType, genre: genreStr, date: date, overview: overview, backdropImage: backdropImage, posterImage: posterImage)
                            bundleList.list.append(newMedia)
                            
                        } else {
                            // 위 else문에서는 없는 경우니까 요청해서 새로 추가
                            self.callGenreRequest(url: URL.getGenreURL(media: .tv), id: genreId) { content in
                                genreStr = content["name"].stringValue
                                let id = element["id"].intValue
                                var title = element["title"].stringValue
                                if title.isEmpty {
                                    title = element["original_name"].stringValue
                                }
                                var date = element["release_date"].stringValue
                                if date.isEmpty {
                                    date = element["first_air_date"].stringValue
                                }
                                let overview = element["overview"].stringValue
                                let backdropImage = element["backdrop_path"].stringValue
                                let posterImage = element["poster_path"].stringValue
                                
                                let newMedia = TrendMedia(id: id, title: title, mediaType: mediaType, genre: genreStr, date: date, overview: overview, backdropImage: backdropImage, posterImage: posterImage)
                                bundleList.list.append(newMedia)
                            }
                        }
                        
                    } else {
                        
                        if let genre = TMDBManager.movieGenreList[genreId] {
                            
                            genreStr = genre
                            let id = element["id"].intValue
                            let title = element["title"].stringValue
                            let date = element["release_date"].stringValue
                            let overview = element["overview"].stringValue
                            let backdropImage = element["backdrop_path"].stringValue
                            let posterImage = element["poster_path"].stringValue
                            
                            let newMedia = TrendMedia(id: id, title: title, mediaType: mediaType, genre: genreStr, date: date, overview: overview, backdropImage: backdropImage, posterImage: posterImage)
                            bundleList.list.append(newMedia)
                            
                        } else {
                            
                            self.callGenreRequest(url: URL.getGenreURL(media: .movie), id: genreId) { content in
                                genreStr = content["name"].stringValue
                                let id = element["id"].intValue
                                let title = element["title"].stringValue
                                let date = element["release_date"].stringValue
                                let overview = element["overview"].stringValue
                                let backdropImage = element["backdrop_path"].stringValue
                                let posterImage = element["poster_path"].stringValue
                                
                                let newMedia = TrendMedia(id: id, title: title, mediaType: mediaType, genre: genreStr, date: date, overview: overview, backdropImage: backdropImage, posterImage: posterImage)
                                bundleList.list.append(newMedia)
                            }
                        }
                        
                    }
                    
                }
                completionHandler()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func callGenreRequest(url: String, id: Int, completionHandler: @escaping (JSON) -> ()) {
        AF.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for genre in json["genres"] {
                    let content = genre.1
                    if content["id"].intValue == id {
                        completionHandler(content)
                        return
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
