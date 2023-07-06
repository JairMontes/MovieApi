//
//  Companies.swift
//  MovieApi
//
//  Created by Admin on 03/07/23.
//

import Foundation

struct Companie : Codable {
    
    var id : Int
    var name : String
    var logo_path : String?
    var origin_country : String
}


struct DetailResponse<T : Codable> : Codable{
    var production_companies : [T]
}
