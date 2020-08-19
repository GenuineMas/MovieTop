//
//  NetworkManager.swift
//  MovieTop
//
//  Created by Genuine on 19.08.2020.
//  Copyright © 2020 Genuine. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

let apiKey = "api_key=65d1815bddd8c90dd8f795081ea294b8&language=en-US&page=1"
let baseURL = "https://api.themoviedb.org/3/movie/"
let baseImageURL = "https://image.tmdb.org/t/p/w500/"
let popular = "popular?"
let topRated = "top_rated?"
let upcoming = "upcoming?"

class NetworkManager: ObservableObject {
    
     private let movieResults = "https://api.themoviedb.org/3/movie/upcoming?api_key=65d1815bddd8c90dd8f795081ea294b8&language=en-US&page=2"

    
    var didChange = PassthroughSubject<NetworkManager,Never>()
  
    init() {
        loadData()
        
    }
    
    @Published var movieList = [Movie](){
        didSet {
            didChange.send(self)
        }
    }
    

    func loadData() {
        
        guard let url = URL(string: movieResults) else { return }
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else { return }
            let movieJSON = try! JSONDecoder().decode(MovieList.self, from: data)
            
            DispatchQueue.main.async {
                self.movieList = movieJSON.results
                print(self.movieList)
            }
        }.resume()
        

    }
    

}

