//
//  MovieDetail.swift
//  MovieTop
//
//  Created by Genuine on 19.08.2020.
//  Copyright © 2020 Genuine. All rights reserved.
//

import SwiftUI

struct MovieDetail : View {
    var movie: Movie
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .bottom) {
                ImageView(withURL: baseImageURL+movie.poster)
                
                Rectangle()
                    .frame(height: 80)
                    .opacity(0.25)
                    .blur(radius: 10)
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(movie.title)
                            .foregroundColor(.white)
                            .bold()
                            .font(.largeTitle)
                    }
                    .padding(.leading)
                    .padding(.bottom)
                    Spacer()
                }
            }
            VStack(alignment: .center,spacing: 15) {
                Text(movie.overview)
                    .foregroundColor(.primary)
                    .font(.body)
                    .lineSpacing(14)
            }.padding(.all)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,maxHeight: .infinity, alignment: .topLeading)
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
    }
}

