//
//  Show.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 19/3/26.
//

import Foundation

struct ShowResponse: Decodable {
    let show: Show
}

struct Show: Decodable {
    let name: String
    let summary: String?
    let image: ImageMovie?
}

struct ImageMovie: Decodable {
    let medium: String?
}
