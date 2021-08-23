//
//  PostCellViewModel.swift
//  Backend Test
//
//  Created by CJ Wheelan on 12/31/20.
//

import Foundation
import Combine

class PostCellViewModel: ObservableObject, Identifiable {
    @Published var postRepository = PostRepository()
    @Published var post: Post
    
    var id = ""
    @Published var completionStateIconName = ""
    
    private var cancellables = Set<AnyCancellable>()

    init(post: Post) {
        self.post = post
        
        $post
            .map { post in
                post.completed ? "checkmark.circle.fill" : "circle"
            }
            .assign(to: \.completionStateIconName, on: self)
            .store(in: &cancellables)
        
        $post
            .compactMap { post in
                post.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        $post
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { post in
                self.postRepository.updatePost(post)
            }
            .store(in: &cancellables)
    }
}
