//
//  MovieListView.swift
//  MovieTop
//
//  Created by Genuine on 18.08.2020.
//  Copyright © 2020 Genuine. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State private var selectorIndex = 0
    @State private var numbers = ["Top Rated","Popular","Upcoming"]
    
   @ObservedObject private var networkManager = NetworkManager()
    var body: some View {
        
        NavigationView {
            VStack{
                
                List (networkManager.movieList) { movie in
                    NavigationLink(destination: MovieDetail(movie: movie)) {

                        MovieRow(movie: movie)

                    }
                }.navigationBarTitle(Text("Movie")).id(UUID())
                

          
                
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
