//
//  TrendsMedia.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/13.
//

import Foundation

struct TrendsMedia {
    var id: Int
    var title: String
    var mediaType: String
    var type: Media {
        return Media(rawValue: self.mediaType) ?? .movie
    }
    var genre: String
    var date: String
    var overview: String
    var backdropImage: String
    var backdropURL: URL? {
        return URL.makeImageURL(imagePath: backdropImage)
    }
    var posterImage: String
    var posterURL: URL? {
        return URL.makeImageURL(imagePath: posterImage)
    }
}

/*
 {
     "adult": false,
     "backdrop_path": "/ibjKNVEk348eIXnvwEz2wC45MGs.jpg",
     "id": 724209,
     "title": "Heart of Stone",
     "original_language": "en",
     "original_title": "Heart of Stone",
     "overview": "An intelligence operative for a shadowy global peacekeeping agency races to stop a hacker from stealing its most valuable — and dangerous — weapon.",
     "poster_path": "/vB8o2p4ETnrfiWEgVxHmHWP9yRl.jpg",
     "media_type": "movie",
     "genre_ids": [
         53,
         28
     ],
     "popularity": 245.952,
     "release_date": "2023-08-09",
     "video": false,
     "vote_average": 7.366,
     
 */
