//
//  ExploreView.swift
//  Backend Test
//
//  Created by CJ Wheelan on 1/3/21.
//

import SwiftUI

struct ExploreView: View {
    
    @EnvironmentObject var postListVM: PostListViewModel
    
    @State private var searchTerm = ""
    
    @State private var filterViewIsShown = false
    @State private var categoryChoice = "All"
    @State private var sortChoice = "Newest Posts First (default)"
    
//    @Binding var isActive : Bool
    
    
    var filteredPosts : [PostCellViewModel] {
        var currentPosts = self.postListVM.postCellViewModels
        
        currentPosts = currentPosts.filter { postCellVM in
            categoryChoice == "All" ? true : postCellVM.post.category == categoryChoice
        }
        
        currentPosts.sort { postCellVM1, postCellVM2 in
            sortChoice == "Newest Posts First (default)" ? (postCellVM1.post.createdTime?.dateValue()) ?? Date() > (postCellVM2.post.createdTime?.dateValue()) ?? Date() : (postCellVM1.post.createdTime?.dateValue()) ?? Date() < (postCellVM2.post.createdTime?.dateValue()) ?? Date()
        }
        return currentPosts
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchTerm)
                
                ScrollView {
                    ForEach(filteredPosts.filter({
                        self.searchTerm == "" ? true : $0.post.title.localizedCaseInsensitiveContains(self.searchTerm)
                    })) { postCellVM in
                        
//                        PostView(postCellVM: postCellVM, isActive: $isActive)
                        PostView(postCellVM: postCellVM)
                    }
                }
            }.navigationTitle("Explore")
            .navigationBarItems(trailing: Button(action: {
                filterViewIsShown.toggle()
            }, label: {
                Image(systemName: "slider.horizontal.3")
                    .font(.largeTitle)
            }))
            
        }.sheet(isPresented: $filterViewIsShown, content: {
            FilterView(filterViewIsShown: $filterViewIsShown, categoryChoice: $categoryChoice, sortChoice: $sortChoice)
        })
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        
        ExploreView()
        
//        ExploreView(isActive: Binding.constant(false))
    }
}
