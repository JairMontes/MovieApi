//
//  Usuario.swift
//  MovieApi
//
//  Created by Admin on 04/07/23.
//

import Foundation

struct Usuario : Decodable{
    var success : Bool
    var session_id : String
}


struct User : Codable{
    var avatar : Avatar
    var id : Int?
    var username : String?
    var name : String?
}

struct Avatar : Codable{
    
    var tmdb : AvatarPath
    
}

struct AvatarPath : Codable {
    
    var avatar_path : String?
    
    init(avatar_path : String? = nil)
    {
        self.avatar_path = ""
    }
    
}
