//
//  Root.swift
//  MovieApi
//
//  Created by Admin on 28/06/23.
//

import Foundation

struct Root< T : Codable>: Codable {
    var results : [T]
}
