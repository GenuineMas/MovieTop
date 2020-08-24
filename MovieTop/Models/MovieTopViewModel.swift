//
//  MovieTopViewModel.swift
//  MovieTop
//
//  Created by Genuine on 23.08.2020.
//  Copyright © 2020 Genuine. All rights reserved.
//

import Foundation

import SwiftUI
import Combine

class MoviesViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    @Published private(set) var state = State()
    @Published var groupState = false
    @Published var groupFromPicker : Int = 0 {
        didSet {
            didChangeStateOfGroup()
            state.movies = []
            updater()
            state.canLoadNextPage = true
        }
    }
    
    
    func fetchNextMovieBatch() {
        guard state.canLoadNextPage else { return }
        MovieAPI.searchMovie(groupMovie: groupMovie[groupFromPicker], page: state.page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: onReceive,
                  receiveValue: onReceive)
            .store(in: &subscriptions)
    }
    
    private func didChangeStateOfGroup() {
        groupState = true
    }
    
    func updater() {
        DispatchQueue.main.async {
            self.state.movies = []
            self.state.page = 1
            print(groupMovie[self.groupFromPicker])
            self.fetchNextMovieBatch()
        }
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
        state.movies += batch
        state.page += 1
        state.canLoadNextPage = batch.count > 1
    }
    
    struct State {
        var movies: [Movie] = []
        var page: Int = 1
        var canLoadNextPage = true
        var groupChanged = false
    }
}







