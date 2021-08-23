//
//  ProfileView.swift
//  Backend Test
//
//  Created by CJ Wheelan on 1/3/21.
//

import SwiftUI

struct ProfileView: View {
    
//    @Binding var settingsIsActive : Bool
//    @Binding var likedPostsIsActive : Bool
//    @Binding var myPostsIsActive : Bool
//    @Binding var postIsActive : Bool
    
    var body: some View {
        NavigationView {
            List {
                
                NavigationLink(
                    destination: SettingsView(),
//                    isActive: $settingsIsActive,
                    label: {
                        
                        HStack {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                    })
                    .isDetailLink(false)

                
                NavigationLink(
//                    destination: LikedPostsView(isActive: $postIsActive),
//                    isActive: $likedPostsIsActive,
                    destination: LikedPostsView(),
                    label: {
                        
                        HStack {
                            Image(systemName: "heart")
                            Text("Liked Posts")
                        }
                    })
                    .isDetailLink(false)

                
                NavigationLink(
//                    destination: YourPostsView(isActive: $postIsActive),
//                    isActive: $myPostsIsActive,
                    destination: YourPostsView(),
                    label: {
                        
                        HStack {
                            Image(systemName: "rectangle.stack.person.crop")
                            Text("My Posts")
                        }
                    })
                    .isDetailLink(false)

                
                
            }.navigationTitle("My Account")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
//        ProfileView(settingsIsActive: Binding.constant(false), likedPostsIsActive: Binding.constant(false), myPostsIsActive: Binding.constant(false), postIsActive: Binding.constant(false))
        
        ProfileView()

    }
}
