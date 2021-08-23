//
//  YourPostsView.swift
//  Backend Test
//
//  Created by CJ Wheelan on 1/23/21.
//

import SwiftUI
import Firebase

struct YourPostsView: View {
    
    @EnvironmentObject var postListVM: PostListViewModel
    
//    @Binding var isActive : Bool
    
    var body: some View {
       
            VStack(alignment: .leading) {
                ScrollView {
                    ForEach(postListVM.postCellViewModels.filter({
                        $0.post.user == (Auth.auth().currentUser?.email)!
                    })) { postCellVM in
                        
//                        PostView(postCellVM: postCellVM, isActive: $isActive)
                        
                        PostView(postCellVM: postCellVM)
                    }
                }
                
            }.navigationTitle("My Posts")
        
    }
}

struct YourPostsView_Previews: PreviewProvider {
    static var previews: some View {
//        YourPostsView(isActive: Binding.constant(false))
//            .environmentObject(PostListViewModel())
        
        YourPostsView()
            .environmentObject(PostListViewModel())
    }
}
