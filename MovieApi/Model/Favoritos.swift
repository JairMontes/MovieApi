//
//  Favoritos.swift
//  MovieApi
//
//  Created by Admin on 04/07/23.
//

import Foundation

struct Detalle : Codable {
    
    var id : Int?
    var original_language : String?
    var original_title : String?
    var overview : String?
    var popularity : Float?
    var poster_path : String?
    var release_date : String?
    var homepage : String?


    init(){
        
        self.id = 0
        self.original_language = ""
        self.original_title = ""
        self.overview = ""
        self.popularity = 0
        self.poster_path = ""
        self.release_date = ""
        
        
    }
}
