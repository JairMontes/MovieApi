//
//  Result.swift
//  MovieApi
//
//  Created by Admin on 28/06/23.
//

import Foundation

struct Result {
    
    var Correct : Bool?
    var ErrorMessage : String?
    var Objects : [Any]?
    var Object : Any?
    var Ex : Error?
    
    init(){
        self.Correct = false
        self.ErrorMessage = ""
        self.Objects = nil
        self.Object = nil
    }
}
