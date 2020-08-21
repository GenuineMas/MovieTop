//
//  NetworkManager.swift
//  MovieTop
//
//  Created by Genuine on 19.08.2020.
//  Copyright © 2020 Genuine. All rights reserved.
//

import Foundation
import Combine

 var page = 1
let apiKey = "api_key=65d1815bddd8c90dd8f795081ea294b8&language=en-US&page=1"
let baseURL = "https://api.themoviedb.org/3/movie/"
let baseImageURL = "https://image.tmdb.org/t/p/w500/"
let popular = "popular?"
let topRated = "top_rated?"
let upcoming = "upcoming?"
let groupMovie = [popular,topRated,upcoming]



class MovieAPI {
    
    
    
    static func searchMovie(groupMovie: String, page: Int) -> AnyPublisher<[Movie], Error> {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(groupMovie)api_key=65d1815bddd8c90dd8f795081ea294b8&language=en-US&page=\(page )")!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .handleEvents(receiveOutput: { print(NSString(data: $0.data, encoding: String.Encoding.utf8.rawValue)!) })
            .tryMap { try JSONDecoder().decode(MovieList<Movie>.self, from: $0.data).results }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
      
    }
}

    
//
//    func loadData(page:Int = 1 ) {
//
//        guard let url = URL(string: movieResults+String(page)) else { return }
//        URLSession.shared.dataTask(with: url){ (data, _, _) in
//            guard let data = data else { return }
//            let movieJSON = try! JSONDecoder().decode(MovieList.self, from: data)
//
//            DispatchQueue.main.async {
//                self.movieList = movieJSON.results
//                print(self.movieList)
//            }
//        }.resume()
//
//
//    }
//
//
//}

