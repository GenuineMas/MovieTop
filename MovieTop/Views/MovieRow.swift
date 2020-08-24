//
//  MovieRow.swift
//  MovieTop
//
//  Created by Genuine on 20.08.2020.
//  Copyright © 2020 Genuine. All rights reserved.
//

import SwiftUI

struct MovieRow: View {
    var movie: Movie
    var body: some View {
        
        HStack {
            ImageView(withURL: baseImageURL + movie.poster)
                .scaledToFit()
                .frame(width: 75, height: 75, alignment: .leading)
            VStack(alignment: .leading){
                Text(" \(movie.title)").bold().underline()
                Text("\(movie.overview)")
            }
        }
    }
}
