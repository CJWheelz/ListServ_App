//
//  PostListViewModel.swift
//  Backend Test
//
//  Created by CJ Wheelan on 12/31/20.
//

import Foundation
import Combine

class PostListViewModel: ObservableObject {
    @Published var postRepository = PostRepository()
    @Published var postCellViewModels = [PostCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        postRepository.$posts
            .map { posts in
                posts.map { post in
                    PostCellViewModel(post: post)
                }
            }
            .assign(to: \.postCellViewModels, on: self)
            .store(in: &cancellables)
    }
    
    func addPost(post: Post) {
        self.postRepository.addPost(post)
    }
    
    func updatePost(post: Post) {
        self.postRepository.updatePost(post)
    }
    
    func deletePost(post: Post) {
        self.postRepository.deletePost(post)
    }
}
