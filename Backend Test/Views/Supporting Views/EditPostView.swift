//
//  EditPostView.swift
//  Backend Test
//
//  Created by CJ Wheelan on 1/31/21.
//

import SwiftUI
import Firebase

struct EditPostView: View {
    
    @EnvironmentObject var postListVM : PostListViewModel
    @ObservedObject var postCellVM : PostCellViewModel
    
    @Binding var showEditMode : Bool
    
    @State private var title = ""
    @State private var description = ""
    @State private var phone = ""
    @State private var email = ""
    
    static let categories = ["ISO (In Search Of)", "FS (For Sale)", "Advertisements", "Lost and Found", "Announcements"]
    @State private var categoryChoice = ""
    
    @State private var errorIsShown = false
    @State private var errorMessage = ""
    @State private var deleteAlertShown = false
    
    
    @State var showActionSheet = false
    @State var showImagePicker = false
    
    @State var sourceType:UIImagePickerController.SourceType = .photoLibrary
    
    // @State var upload_image:UIImage?
    @Binding var image2 : UIImage?
    @State var deleteImageAlertShown = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                // Text("Edit Your Post").font(.largeTitle)
                
                Form {
                    
                    Section(header: Text("Post Info")) {
                        TextField(postCellVM.post.title, text: $title).onAppear {
                            title = postCellVM.post.title
                        }
                        
                        TextEditor(text: $description).onAppear {
                            description = postCellVM.post.description
                        }
                        
                        
                        Picker("Choose a Category", selection: $categoryChoice) {
                            ForEach(AddPostView.categories, id: \.self) { category in
                                Text(category)
                            }
                        }.onAppear {
                            categoryChoice = postCellVM.post.category
                        }
                        
                    }
                    
                    Section(header: Text("Choose/Edit Image (Optional)")) {
                        if image2 != nil {
                            Image(uiImage: image2!)
                                .resizable()
                                .scaledToFit()
                                //.frame(width: UIScreen.main.bounds.width - 50)
                        } else {
                            Text("No image selected")
                        }
                        
                        // Button for image picker
                        Button(action: {
                            self.showActionSheet = true
                        }) {
                            Text("Choose an image")
                        }.actionSheet(isPresented: $showActionSheet){
                            ActionSheet(title: Text("Add a picture to your post"), message: nil, buttons: [
//                                //Button1
//
//                                .default(Text("Camera"), action: {
//                                    self.showImagePicker = true
//                                    self.sourceType = .camera
//                                }),
                                //Button2
                                .default(Text("Photo Library"), action: {
                                    self.showImagePicker = true
                                    self.sourceType = .photoLibrary
                                }),
                                
                                //Button3
                                .cancel()
                                
                            ])
                        }.sheet(isPresented: $showImagePicker){
                            imagePicker(image: self.$image2, showImagePicker: self.$showImagePicker, sourceType: self.sourceType)
                            
                        }
                        
                        if postCellVM.post.image != "" {
                            
                            Button(action: {
                                deleteImageAlertShown.toggle()
                            }, label: {
                                Text("Delete this image")
                                    .foregroundColor(.red)
                            })
                            .alert(isPresented: $deleteImageAlertShown) {
                                Alert(
                                    title: Text("Are you sure you want to delete this image?"),
                                    message: Text("This action cannot be undone."),
                                    primaryButton: .destructive(Text("Delete")) {
                                        deleteImage(id: postCellVM.post.image)
                                        image2 = nil
                                        postCellVM.post.image = ""
                                        showEditMode.toggle()
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                        }
                        
                    }
                    
                    Section(header: Text("Contact Info")) {
                        TextField(postCellVM.post.phone != "" ? postCellVM.post.phone : "No Phone Number", text: $phone).onAppear {
                            phone = postCellVM.post.phone != "" ? postCellVM.post.phone : ""
                        }
                        .keyboardType(.phonePad)
                        
                        TextField(postCellVM.post.email != "" ? postCellVM.post.email : "No Email Address", text: $email).onAppear {
                            email = postCellVM.post.email != "" ? postCellVM.post.email : ""
                        }
                        .keyboardType(.emailAddress)
                        
                        
                        
                        
                    }
                    
                    Section {
                        Button(action: {
                            
                            if phone != "" && (Int(phone) == nil || phone.count != 10) {
                                self.errorMessage = "Please check to make sure your phone number is properly formatted."
                                errorIsShown.toggle()
                            }
                            else if email != "" && !email.isValidEmail {
                                self.errorMessage = "Please check to make sure your email is properly formatted."
                                errorIsShown.toggle()
                            }
                            else {
                                
                                var id = ""
                                if image2 != nil {
                                    id = UUID().uuidString
                                    uploadImage(id: id, image: image2!)
                                    deleteImage(id: postCellVM.post.image)
                                }
                                
                                postCellVM.post.title = title == "" ? postCellVM.post.title : title
                                postCellVM.post.description = description == "" ? postCellVM.post.description : description
                                postCellVM.post.phone = phone == "" ? postCellVM.post.phone : phone
                                postCellVM.post.email = email == "" ? postCellVM.post.email : email
                                postCellVM.post.category = categoryChoice == "" ? postCellVM.post.category : categoryChoice
                                postCellVM.post.image = id
                                
                                postListVM.updatePost(post: postCellVM.post)
                                
                                //                                self.title = ""
                                //                                self.description = ""
                                //                                self.email = ""
                                //                                self.phone = ""
                                //                                self.categoryChoice = ""
                                //
                                //                                upload_image = nil
                                
                                showEditMode.toggle()
                            }
                            
                            
                        }, label: {
                            Text("Update Post!")
                        })
                    }
                    
                    Section {
                        Button(action: {
                            deleteAlertShown.toggle()
                        }, label: {
                            Text("Delete this post")
                                .foregroundColor(.red)
                        })
                    }.alert(isPresented: $deleteAlertShown) {
                        Alert(
                            title: Text("Are you sure you want to delete this?"),
                            message: Text("This action cannot be undone."),
                            primaryButton: .destructive(Text("Delete")) {
                                
                                postListVM.deletePost(post: postCellVM.post)
                                showEditMode.toggle()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    
                    
                }
                
            }
            .navigationTitle("Edit Post")
            
            .alert(isPresented: $errorIsShown, content: {
                Alert(title: Text("Watch Out!"), message: Text(errorMessage), dismissButton: .default(Text("Got it!")))
            })
            
            .navigationBarItems(trailing: Button("Cancel") {
                showEditMode.toggle()
            })
        }
    }
}

struct EditPostView_Previews: PreviewProvider {
    static var previews: some View {
        EditPostView(postCellVM: PostCellViewModel(post: samplePost), showEditMode: Binding.constant(true), image2: Binding.constant(UIImage())).environmentObject(PostListViewModel())
    }
}
