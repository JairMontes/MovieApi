//
//  Detail.swift
//  MovieApi
//
//  Created by Admin on 03/07/23.
//

import Foundation

struct DetailCompanies <T : Codable> : Codable{
    var production_companies : [T]
}
