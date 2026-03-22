//
//  Song.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 19/3/26.
//

import Foundation

struct SongResponse: Decodable {
    let resultCount: Int
    let results: [Song]
}

struct Song: Decodable {
    let trackName: String?
    let artistName: String?
    let artworkUrl100: String?
    let previewUrl: String?
}
