//
//  TestViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/13.
//

import UIKit

class TestViewController: UIViewController {

    var list: [TrendsMedia] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        TMDBManager.shared.callRequest { element in
            let id = element["id"].intValue
            let title = element["title"].stringValue
            let mediaType = element["media_type"].stringValue
            let genre = element["genre_ids"][0].intValue
            let date = element["release_date"].stringValue
            let overview = element["overview"].stringValue
            let backdropImage = element["backdrop_path"].stringValue
            let posterImage = element["poster_path"].stringValue
            let newMedia = TrendsMedia(id: id, title: title, mediaType: mediaType, genre: genre, date: date, overview: overview, backdropImage: backdropImage, posterImage: posterImage)
            self.list.append(newMedia)
            print("================")
            print("totalList: \(self.list)")
        }
//        TMDBManager.shared.callGenereRequest(url: URL.genreURL, id: 12)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
