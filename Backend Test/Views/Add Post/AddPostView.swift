//
//  AddPostView.swift
//  Backend Test
//
//  Created by CJ Wheelan on 1/3/21.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct AddPostView: View {
    
    @EnvironmentObject var postListVM : PostListViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var phone = ""
    @State private var email = ""
    
    @State private var includeEmail = false
    @State private var includePhone = false
    
    static let categories = ["ISO (In Search Of)", "FS (For Sale)", "Advertisements", "Lost and Found", "Announcements", "Other"]
    @State private var categoryChoice = ""
    
    @State private var errorIsShown = false
    @State private var errorMessage = ""
    @State private var successfulPost = false
    
    @Binding var selected: Int
//    @Binding var homeIsActive: Bool
    @Binding var home : UUID
    
    // NEW
    @State var showActionSheet = false
    @State var showImagePicker = false
    
    @State var sourceType:UIImagePickerController.SourceType = .photoLibrary
    
    @State var upload_image:UIImage?
    let user = (Auth.auth().currentUser?.email)!
    
    var body: some View {
        
        NavigationView {
            
            
            Form {
                Section(header: Required(header: "Post Info")) {
                    
                    TextField("Title of your post", text: $title)
                    
                    TextEditor(text: $description)
                    
                    Picker("Choose a Category", selection: $categoryChoice) {
                        ForEach(AddPostView.categories, id: \.self) { category in
                            Text(category)
                        }
                    }
                }
                
                Section(header: Text("Choose an Image (Optional)")) {
                    // Image
                    if upload_image != nil {
                        Image(uiImage: upload_image!)
                            .resizable()
                            .scaledToFit()
                        //                            .frame(width:120, height:120)
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
                            //Button1
                            
//                            .default(Text("Camera"), action: {
//                                self.showImagePicker = true
//                                self.sourceType = .camera
//                            }),
                            //Button2
                            .default(Text("Photo Library"), action: {
                                self.showImagePicker = true
                                self.sourceType = .photoLibrary
                            }),
                            
                            //Button3
                            .cancel()
                            
                        ])
                    }.sheet(isPresented: $showImagePicker){
                        imagePicker(image: self.$upload_image, showImagePicker: self.$showImagePicker, sourceType: self.sourceType)
                        
                    }
                    
                }
                
                Section(header: Required(header: "Contact Info")) {
                    Toggle(isOn: $includePhone.animation(), label: {
                        Text("Include a phone number")
                    })
                    
                    if includePhone {
                        TextField("1234567890", text: $phone)
                            .keyboardType(.phonePad)
                    }
                    
                    Toggle(isOn: $includeEmail.animation(), label: {
                        Text("Include an email")
                    })
                    
                    if includeEmail {
                        TextField("example@example.com", text: $email)
                            .keyboardType(.emailAddress)
                            .onAppear {
                                email = user
                            }
                    }
                    
                    Text("The email associated with this account will automatically be displayed at the bottom of your post.")
                        .font(.footnote)
                        .foregroundColor(Color.gray)
                    
                }
                
                
                Button(action: {
                    if title == "" {
                        errorMessage = "Please give your post a title."
                        self.errorIsShown.toggle()
                    }
                    else if description == "" {
                        errorMessage = "Please give your post a description."
                        self.errorIsShown.toggle()
                    }
                    else if categoryChoice.count < 1 {
                        errorMessage = "Please select a category for your post."
                        self.errorIsShown.toggle()
                    }
                    else if (phone == "" && email == "") || (!includePhone && !includeEmail) {
                        errorMessage = "Please give your post a contact phone number and/or email."
                        self.errorIsShown.toggle()
                    }
                    else if includePhone && (Int(phone) == nil || phone.count != 10) {
                        errorMessage = "Please give a valid phone number."
                        self.errorIsShown.toggle()
                    }
                    else if includeEmail && !email.isValidEmail {
                        errorMessage = "Please give a valid email."
                        self.errorIsShown.toggle()
                    }
                    else {
                        
                        
                        var id = ""
                        
                        if upload_image != nil {
                            id = UUID().uuidString
                            uploadImage(id: id, image: upload_image!)
                        }
                        
                        
                        postListVM.addPost(post: Post(title: self.title, completed: true, category: categoryChoice, description: self.description, email: includeEmail ? self.email : "", phone: includePhone ? self.phone : "", user: (Auth.auth().currentUser?.email)!, image: id))
                        
                        
                        self.title = ""
                        self.description = ""
                        self.email = ""
                        self.phone = ""
                        self.categoryChoice = ""
                        includePhone = false
                        includeEmail = false
                        upload_image = nil
                        
                        successfulPost.toggle()
                        
                    }
                    
                }, label: {
                    Text("Add Post!")
                })
                .alert(isPresented: $errorIsShown, content: {
                    Alert(title: Text("Watch Out!"), message: Text(errorMessage), dismissButton: .default(Text("Got it!")))
                })
                
            }.navigationTitle("Add Post")
            
        }
        .alert(isPresented: $successfulPost, content: {
            Alert(
                title: Text("Hooray!"),
                message: Text("You successfully posted!"),
                primaryButton: .default(
                    Text("Home"),
                    action: {
                        home = UUID()
//                        homeIsActive = false
                        selected = 0

                    }
                ),
                secondaryButton: .default(
                    Text("Post Again"),
                    action: {
                        successfulPost.toggle()
                    }
                )
            )
        })
        .accentColor(Color.blue)
        
    }
}

struct AddPostView_Previews: PreviewProvider {
    static var previews: some View {
        
        AddPostView(selected: Binding.constant(2), home: Binding.constant(UUID()))
//        AddPostView(selected: Binding.constant(2), homeIsActive: Binding.constant(true))
    }
}
