//
//  RepositoriesList.swift
//  InfiniteListSwiftUI
//
//  Created by Vadim Bulavin on 6/10/20.
//  Copyright © 2020 Vadim Bulavin. All rights reserved.
//

import SwiftUI
import Combine

class MoviesViewModel: ObservableObject {
    @Published private(set) var state = State()
    var groupFromPicker = Int() {
        didSet{
            fetchNextPageIfPossible()
        }
    }
    let popular = "popular?"
    let topRated = "top_rated?"
    let upcoming = "upcoming?"
  
 
    private var subscriptions = Set<AnyCancellable>()
    
    func fetchNextPageIfPossible() {
        guard state.canLoadNextPage else { return }
        
        let groupMovie = [popular,topRated,upcoming]
        print(groupMovie[groupFromPicker])
        
        MovieAPI.searchMovie(groupMovie: groupMovie[groupFromPicker], page: state.page)
            .sink(receiveCompletion: onReceive,
                  receiveValue: onReceive)
            .store(in: &subscriptions)
        
    }
    
    private func onReceive(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure:
            state.canLoadNextPage = false
        }
    }
    
    private func onReceive(_ batch: [Movie]) {
        state.repos += batch
        state.page += 1
        state.canLoadNextPage = batch.count > 10
    }
    
    struct State {
        var repos: [Movie] = []
        var page: Int = 1
        var canLoadNextPage = true
    }
}


struct MoviesListContainer: View {
  

    @ObservedObject var viewModel: MoviesViewModel
    @State  var selectorIndex = 0
    @State  var groups = ["Top Rated","Popular","Upcoming"]
 
    
    func getPickerValue(value:Int) {
        
        self.viewModel.groupFromPicker = value
       // print(viewModel.groupFromPicker)
    }
    
    
    var body: some View {
        
        
        NavigationView {
            VStack{
               
                Picker("Groups", selection: self.$selectorIndex) {
               
                    
                    ForEach(0 ..< self.groups.count) { index in
                         
                        Text(self.groups[index]).tag(index)
                    }
                }
                //.onAppear(perform: self.viewModel.fetchNextPageIfPossible)
                .onReceive([self.selectorIndex].publisher.first()) { value in
                               self.getPickerValue(value: value)
                   // self.viewModel.fetchNextPageIfPossible
                    }
                .pickerStyle(SegmentedPickerStyle())

                RepositoriesList(
                    movies: viewModel.state.repos,
                    isLoading: viewModel.state.canLoadNextPage,
                    onScrolledAtBottom: viewModel.fetchNextPageIfPossible
                    )
                    .onAppear(perform: viewModel.fetchNextPageIfPossible )
                //.navigationBarTitle(Text("Movie")).id(UUID())
            }
        
        }
    }
}

struct RepositoriesList: View {
    let movies: [Movie]
    let isLoading: Bool
    let onScrolledAtBottom: () -> Void
    
    var body: some View {
        List {
            reposList
            if isLoading {
                loadingIndicator
            }
        }
    }
    
    private var reposList: some View {
        ForEach(movies) { movie in
            
       NavigationLink(destination: MovieDetail(movie: movie)) {
            
            MovieRow(movie: movie).onAppear {
                if self.movies.last == movie {
                    self.onScrolledAtBottom()
                }
            }
            
            }
            
            
        }.navigationBarTitle(Text("Movie")).id(UUID())
    }
    
    private var loadingIndicator: some View {
        Spinner(style: .medium)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
}





