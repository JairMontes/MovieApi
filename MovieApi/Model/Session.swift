//
//  Session.swift
//  MovieApi
//
//  Created by Admin on 04/07/23.
//

import Foundation

struct Session : Codable{
    
    var success : Bool
    var expires_at : String?
    var request_token : String?
}

struct Error : Codable {
    var success : Bool
    var status_code : Int
    var status_message : String
}
