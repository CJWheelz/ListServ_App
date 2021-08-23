//
//  TabIconView.swift
//  Backend Test
//
//  Created by CJ Wheelan on 1/3/21.
//

import SwiftUI

struct TabIconView: View {
    
//    @State var selected: String = "Post"
    
    @State private var selection = 0
    @State private var home = UUID()
//    @State private var homeIsActive = false
    
    @State private var explore = UUID()
//    @State private var exploreIsActive = false
    
    @State private var account = UUID()
//    @State private var settingsIsActive = false
//    @State private var likedPostsIsActive = false
//    @State private var myPostsIsActive = false
//    @State private var postIsActive = false
        
        var handler: Binding<Int> { Binding(
            get: { self.selection },
            set: {
                if $0 == self.selection {
                    if $0 == 0 {
//                        homeIsActive = false
                        home = UUID()
                    }
                    else if $0 == 1 {
//                        exploreIsActive = false
                        explore = UUID()
                    }
                    else if $0 == 3 {
//                        postIsActive = false
//                        settingsIsActive = false
//                        likedPostsIsActive = false
//                        myPostsIsActive = false
                        account = UUID()
                    }
                }
                
                self.selection = $0
            }
        )}
    
    var body: some View {
        
        TabView(selection: handler) {
//            ContentView(isActive: $homeIsActive)
            ContentView()
                .id(home)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
                
            
//            ExploreView(isActive: $exploreIsActive)
            ExploreView()
                .id(explore)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }.tag(1)
            
            
//            AddPostView(selected: $selection, homeIsActive: $homeIsActive)
            AddPostView(selected: $selection, home : $home)
                .tabItem {
                    Image(systemName: "plus.square")
                    Text("Post")
                }.tag(2)
            
//            ProfileView(settingsIsActive: $settingsIsActive, likedPostsIsActive: $likedPostsIsActive, myPostsIsActive: $myPostsIsActive, postIsActive: $postIsActive)
            ProfileView()
                .id(account)
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
                .tag(3)
                
        }
        .accentColor(Color.black)
    }
}

struct TabIconView_Previews: PreviewProvider {
    static var previews: some View {
        TabIconView()
    }
}
