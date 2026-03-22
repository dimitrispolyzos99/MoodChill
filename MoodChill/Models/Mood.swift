//
//  Mood.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 19/3/26.
//

import Foundation


enum Mood: Hashable, CaseIterable{
    case Happy
    case Chill
    case Angry
    case Sad
    case Bored
    
    var title: String {
        switch self {
        case .Happy:
            "Happy"
        case .Chill:
            "Chill"
        case .Angry:
            "Angry"
        case .Sad:
            "Sad"
        case .Bored:
            "Bored"
        }
    }
    var symbol: String {
        switch self {
        case .Happy:
            "😄"
        case .Chill:
            "😎"
        case .Angry:
            "😠"
        case .Sad:
            "😢"
        case .Bored:
            "😒"
        }
    }
    var color: String {
        switch self {
        case .Happy:
            "happyColor"
        case .Chill:
            "chillColor"
        case .Angry:
            "angryColor"
        case .Sad:
            "sadColor"
        case .Bored:
            "boredColor"
        }
    }
    var searchTerm: String {
        switch self {
        case .Happy:
            return "happy"
        case .Chill:
            return "lofi"
        case .Angry:
            return "rock"
        case .Sad:
            return "sad"
        case .Bored:
            return "party"
        }
    }
    var quoteCategory: String {
        switch self {
        case .Happy:
            return "happiness"
        case .Chill:
            return "life"
        case .Angry:
            return "success"
        case .Sad:
            return "inspirational"
        case .Bored:
            return "funny"
        }
    }

}
