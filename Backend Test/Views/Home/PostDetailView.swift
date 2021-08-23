//
//  PostDetailView.swift
//  Backend Test
//
//  Created by CJ Wheelan on 1/3/21.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct PostDetailView: View {
    
    @ObservedObject var postCellVM: PostCellViewModel
    
    @EnvironmentObject var likedPostListVM: LikedPostListViewModel
    
    @State private var showEditMode = false
    
    @State var download_image:UIImage?
    
    @State var alertIsShown = false
    @State var message = ""
    
    var isHearted : Bool {
        return self.likedPostListVM.hasLikedPost(post: postCellVM.post)
    }
    
    var date : String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .short
        
        let date1 = dateFormatter.string(from: postCellVM.post.createdTime?.dateValue() ?? Date())
        
        return date1
    }
    
    
    
    var body: some View {
        ScrollView {
            VStack {
                
                HStack {
                    Text("Category:").font(.headline)
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
                    
                }.padding(.top, 20)
                .padding(.horizontal, 20)
                
                Divider()
                
                if postCellVM.post.image != "" {
                    
                    // Downloading Image
                    if download_image != nil {
                        Image(uiImage: download_image!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width - 50)
                    }
                    else {
                        VStack(spacing: 20) {
                            ProgressView()
                            Text("Loading Image")
                        }
                        
                    }
                    
                    Divider()
                        .padding(.horizontal, 20)
                }
                
                
                VStack(alignment: .leading) {
                    Text("Full Description:").font(.headline)
                    
                    Text(postCellVM.post.description)
                        .fixedSize(horizontal: false, vertical: true)
                    //.lineLimit(nil)
                    
                    Divider()
                }.padding(.horizontal, 20)
                
                
                VStack(alignment: .leading) {
                    Text("Contact:").font(.headline)
                    HStack {
                        VStack(alignment: .leading) {
                            postCellVM.post.email != "" ? Text("Email:") : nil
                            postCellVM.post.phone != "" ? Text("Phone:") : nil
                        }
                        VStack(alignment: .leading) {
                            
                            //  Clickable Email Address
                            postCellVM.post.email != "" ? Link("\(postCellVM.post.email)", destination: URL(string: "\("mailto:" + postCellVM.post.email)")!) : nil
                            
                            //  Clickable telephone number
                            postCellVM.post.phone != "" ? Link("\(postCellVM.post.phone)", destination: URL(string: "\("sms:" + postCellVM.post.phone)")!).foregroundColor(Color.blue) : nil
                        }
                        Spacer()
                    }
                }.padding(.horizontal, 20)
                
                // Link that will open Safari on iOS devices
                // Link("Apple", destination: URL(string: "https://www.apple.com")!)
                
                Spacer()
                
                Text("Posted by \(postCellVM.post.user) on \(date)")
                    .font(.footnote)
                    .padding(.horizontal, 20)
                
            }
            .navigationTitle(postCellVM.post.title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: postCellVM.post.user == (Auth.auth().currentUser?.email)! ?
                                    Button("Edit") {
                                        showEditMode.toggle()
                                    }.foregroundColor(Color.blue) : nil
            )
            
            .sheet(isPresented: $showEditMode, content: {
                EditPostView(postCellVM: postCellVM, showEditMode: $showEditMode, image2: $download_image)
            })
            
        }.onAppear() {
            if postCellVM.post.image != "" {
                Storage.storage().reference().child(postCellVM.post.image).getData(maxSize: 10 * 1024*1024) { (data, err) in
                    if let err = err {
                        print("Error: \(err.localizedDescription)")
                    }
                    else {
                        if let imageData = data {
                            download_image = UIImage(data: imageData)
                        }
                        else {
                            print("couldn't unwrap image data")
                        }
                        print("downloaded image successfully")
                    }
                }
            }
        }
        .accentColor(Color.blue)
        
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(postCellVM: PostCellViewModel(post: samplePost))
    }
}
