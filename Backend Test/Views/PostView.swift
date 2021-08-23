//
//  PostView.swift
//  Backend Test
//
//  Created by CJ Wheelan on 1/3/21.
//

import SwiftUI

struct PostView: View {
    @ObservedObject var postCellVM: PostCellViewModel
    
    @EnvironmentObject var likedPostListVM: LikedPostListViewModel
    @EnvironmentObject var rootViewChanger: RootViewChanger
    
//    @Binding var isActive : Bool
    
    var isHearted : Bool {
        return self.likedPostListVM.hasLikedPost(post: postCellVM.post)
    }
    
    var body: some View {
        VStack {
            
            Divider().padding(.top, 0)
            
            HStack {
                Text(postCellVM.post.category)
                
                Spacer()
                
                Text(String(likedPostListVM.likedPostViewModels.filter({ likedPostVM in
                    likedPostVM.likedPost.postID == postCellVM.post.id
                }).count))
                
                Button(action: {
                    
                    let _ = likedPostListVM.hasLikedPost(post: postCellVM.post)
                    
                    if isHearted {
                        likedPostListVM.unlikePost(post: postCellVM.post)
                    }
                    else {
                        likedPostListVM.likePost(post: postCellVM.post)
                    }
                }, label: {
                    Image(systemName: isHearted ? "heart.fill" : "heart")
                        .foregroundColor(.black)
                })
            }.padding(.horizontal)
            // .frame(width: UIScreen.main.bounds.width)
            
            .font(.headline)
            
            Divider()
            
            HStack {
                Spacer()
                Text(postCellVM.post.title)
                    .font(.title)
                    .lineLimit(nil)
                Spacer()
            }
            .padding(.vertical, 30)
            //   .frame(width: UIScreen.main.bounds.width)
            
            
            Divider()
            
            HStack {
                Text(postCellVM.post.description).lineLimit(3)
                Spacer()
            }.padding(.horizontal)
            // .frame(width: UIScreen.main.bounds.width)
            
            
            
            NavigationLink(
                destination: PostDetailView(postCellVM: self.postCellVM)
//                ,
//                isActive: self.$isActive
            ) {
                HStack {
                    Spacer()
                    Text("More Info")
                    Image(systemName: "arrow.turn.down.right")
                    Spacer()
                }.padding()
                .background(Color.black)
                .foregroundColor(.white)
                .font(.headline)
            }
            .isDetailLink(false)
            
            
            
        }.cornerRadius(20)
        .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.secondary, lineWidth: 1).shadow(radius: 10))
        // .shadow(radius: 20)
        
        .padding(10)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(postCellVM: PostCellViewModel(post: samplePost))
            .environmentObject(LikedPostViewModel(likedPost: sampleLikedPost))
            .environmentObject(RootViewChanger())
        
//        PostView(postCellVM: PostCellViewModel(post: samplePost), isActive: Binding.constant(false))
//            .environmentObject(LikedPostViewModel(likedPost: sampleLikedPost))
//            .environmentObject(RootViewChanger())
        
    }
}
