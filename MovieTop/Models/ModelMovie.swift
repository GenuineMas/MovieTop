//
//  ModelMovie.swift
//  MovieTop
//
//  Created by Genuine on 18.08.2020.
//  Copyright © 2020 Genuine. All rights reserved.
//

import Foundation


struct Movie :   Codable,Identifiable,Equatable {
    var id =  UUID()
    var poster : String
    var title : String
    var overview : String
    
    enum CodingKeys: String,CodingKey {
        case poster = "poster_path"
        case overview
        case title
    
    }
}

struct MovieList <T: Codable>: Codable {
    
    var page : Int
    let results : [Movie]
}


