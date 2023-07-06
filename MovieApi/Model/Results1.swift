//
//  Results1.swift
//  MovieApi
//
//  Created by Admin on 29/06/23.
//

import Foundation

struct Results1 : Codable {
   
    var id : Int
    var name : String
    var original_language : String
    var original_name : String
    var overview : String?
    var popularity : Float
    var poster_path : String
    var first_air_date : String
    var vote_average : Float
    
}

struct Serie : Codable {
    var id : Int
    var first_air_date : String
    var name : String
    var overview : String
    var poster_path : String
    var vote_average : Float
    var toPaint : Bool? = nil
    
    init(){
        self.id = 0
        self.first_air_date = ""
        self.name = ""
        self.overview = ""
        self.poster_path = ""
        self.vote_average = 0
    }
}
