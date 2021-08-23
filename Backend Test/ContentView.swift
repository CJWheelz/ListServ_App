//
//  ContentView.swift
//  Backend Test
//
//  Created by CJ Wheelan on 12/31/20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var postListVM : PostListViewModel
    
    // @EnvironmentObject var likedPostListVM : LikedPostListViewModel
    
    //    @Binding var isActive : Bool
    
    var yesterday: Date? {
        var dayComponent = DateComponents()
        dayComponent.day = -1
        let theCalendar = Calendar.current
        let yesterday = theCalendar.date(byAdding: dayComponent, to: Date())
        return yesterday
    }
    
    //    var posts: [PostCellViewModel] {
    //        let posts = postListVM.postCellViewModels
    //            .filter({ postCellVM in
    //                postCellVM.post.createdTime?.dateValue() ?? Date() > yesterday ?? Date()
    //            })
    //
    //        return posts
    //    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView {
                    
                    let posts = postListVM.postCellViewModels
                        .filter({ postCellVM in
                            postCellVM.post.createdTime?.dateValue() ?? Date() > yesterday ?? Date()
                        })
                    
                    if posts.isEmpty {
                        Text("No posts in the last 24 hours.")
                            .padding(.top, 20)
                            .foregroundColor(Color.gray)
                    }
                    else {
                        ForEach(posts) { postCellVM in
                            PostView(postCellVM: postCellVM)
                            //                        PostView(postCellVM: postCellVM, isActive: $isActive)
                        }
                    }
                    
                }
                
            }.navigationTitle("24 Hour Feed")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //        ContentView(isActive: Binding.constant(false))
    }
}
