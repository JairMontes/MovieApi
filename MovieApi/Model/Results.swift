//
//  Results.swift
//  MovieApi
//
//  Created by Admin on 28/06/23.
//

import Foundation

struct Results : Codable {
    
    var id : Int
    var original_language : String
    var original_title : String
    var overview : String
    var popularity : Float
    var poster_path : String
    var release_date : String
    var title : String
    var video : Bool
    var vote_average : Float
    var vote_count : Float
    var genre_ids : [Int] = []
    
}
