//
//  SignInView.swift
//  Backend Test
//
//  Created by CJ Wheelan on 1/10/21.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State private var email = ""
    @State private var password = ""
    @State private var error = ""
    
    func signIn() {
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("Welcome to ListServ!")
                    .font(.largeTitle)
                    .bold()
                    
                Text("Sign in to continue")
                    .foregroundColor(.gray)
                    .padding(.bottom, 50)
                
                // MARK: - Username + Password
                VStack {
                    HStack {
                        Image(systemName: "envelope")
                        
                        TextField("Email", text: $email)
                            .padding(.horizontal)
                            .keyboardType(.emailAddress)
                        
                    }.padding(.horizontal)
                    
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width - 20, height: 2)
                        .foregroundColor(.black)
                        .padding(.bottom, 30)
                    
                    
                    HStack {
                        Image(systemName: "lock").padding(.horizontal, 2)
                        
                        SecureField("Password", text: $password)
                            .padding(.horizontal)
                        
                    }.padding(.horizontal)
                    
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width - 20, height: 2)
                        .foregroundColor(.black)
                        .padding(.bottom, 50)
                    
                    
                    
                    Button(action: signIn, label: {
                        HStack {
                            Text("Sign in!")
                        }.padding(.horizontal, 50)
                        .padding(.vertical)
                        .background(Color.black)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .font(.headline)
                    })
                    
                    if error != "" {
                        Text(error)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }
                    
                    
                }
                
                Spacer()
                
                HStack {
                    Text("Don't have an account?")
                    
                    NavigationLink(
                        destination: SignUpView(),
                        label: {
                            Text("Sign Up!")
                        })
                }.padding()
                
            }
        }
        
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView().environmentObject(SessionStore())
    }
}
