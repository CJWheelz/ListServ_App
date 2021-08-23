//
//  LikedPostListViewModel.swift
//  Backend Test
//
//  Created by CJ Wheelan on 2/24/21.
//

import Foundation
import Combine

class LikedPostListViewModel: ObservableObject {
    @Published var likedPostRepository = LikedPostRepository()
    @Published var likedPostViewModels = [LikedPostViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        likedPostRepository.$likedPosts
            .map { likedPosts in
                likedPosts.map { likedPost in
                    LikedPostViewModel(likedPost: likedPost)
                }
            }
            .assign(to: \.likedPostViewModels, on: self)
            .store(in: &cancellables)
    }
    
    func hasLikedPost(post: Post) -> Bool {
        return self.likedPostRepository.hasLikedPost(post: post)
    }
    
    func likePost(post: Post) {
        self.likedPostRepository.likePost(post: post)
    }
    
    func unlikePost(post: Post) {
        self.likedPostRepository.unlikePost(post: post)
    }
}
