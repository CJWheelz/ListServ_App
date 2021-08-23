//
//  LikedPostViewModel.swift
//  Backend Test
//
//  Created by CJ Wheelan on 2/24/21.
//

import Foundation
import Combine

class LikedPostViewModel: ObservableObject, Identifiable {
    @Published var likedPostRepository = LikedPostRepository()
    @Published var likedPost: LikedPost
    
    var id = ""
    
    private var cancellables = Set<AnyCancellable>()

    init(likedPost: LikedPost) {
        self.likedPost = likedPost
        
        $likedPost
            .compactMap { likedPost in
                likedPost.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
    }
}
