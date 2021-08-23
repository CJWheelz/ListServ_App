//
//  LikedPostsView.swift
//  Backend Test
//
//  Created by CJ Wheelan on 2/24/21.
//

import SwiftUI
import Firebase

struct LikedPostsView: View {
    
    @EnvironmentObject var postListVM: PostListViewModel
    @EnvironmentObject var likedPostListVM: LikedPostListViewModel
    
//    @Binding var isActive : Bool
    
    let user = (Auth.auth().currentUser?.uid)!

    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                
                ForEach(likedPostListVM.likedPostViewModels.filter({ likedPostVM in
                    likedPostVM.likedPost.userID == user
                })
                ) { likedPostVM in
                    
                    let postArray = postListVM.postCellViewModels.filter({ (postCellVM) in
                        postCellVM.post.id == likedPostVM.likedPost.postID
                    })
                    
                    if !postArray.isEmpty {
//                        PostView(postCellVM: postArray[0], isActive: $isActive)
                        PostView(postCellVM: postArray[0])
                    }
                }
            }
            
        }.navigationTitle("My Liked Posts")
    }
}

struct LikedPostsView_Previews: PreviewProvider {
    static var previews: some View {
//        LikedPostsView(isActive: Binding.constant(false))
//            .environmentObject(PostListViewModel())
//            .environmentObject(LikedPostListViewModel())
        
        LikedPostsView()
            .environmentObject(PostListViewModel())
            .environmentObject(LikedPostListViewModel())
    }
}
