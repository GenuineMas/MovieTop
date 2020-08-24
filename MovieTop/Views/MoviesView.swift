//
//  MoviesView.swift
//  MovieTop
//
//  Created by Genuine on 23.08.2020.
//  Copyright © 2020 Genuine. All rights reserved.
//

import SwiftUI

struct MoviesListContainer: View {
    @ObservedObject var viewModel: MoviesViewModel
    var groups = ["Top Rated","Popular","Upcoming"]
    var body: some View {
        NavigationView {
            VStack{
                Picker("Groups", selection: $viewModel.groupFromPicker) {
                    ForEach(0 ..< self.groups.count) { index in
                        Text(self.groups[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                MovieListView(
                    movies: viewModel.state.movies,
                    isLoading: viewModel.state.canLoadNextPage,
                    onScrolledAtBottom: viewModel.fetchNextMovieBatch
                )
                    .onAppear(perform: viewModel.fetchNextMovieBatch )
            }
        }
    }
}

struct MovieListView: View {
    let movies: [Movie]
    let isLoading: Bool
    let onScrolledAtBottom: () -> Void
    
    var body: some View {
        List {
            moviesList
            if isLoading {
                loadingIndicator
            }
        }
    }
    
    private var moviesList: some View {
        ForEach(movies) { movie in
            NavigationLink(destination: MovieDetail(movie: movie)) {
                MovieRow(movie: movie).onAppear {
                    if self.movies.last == movie {
                        self.onScrolledAtBottom()
                    }
                }
            }
        }
        .navigationBarTitle(Text("Movie")).id(UUID())
    }
    
    private var loadingIndicator: some View {
        Spinner(style: .medium)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
}

