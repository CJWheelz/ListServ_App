//
//  SignUpView.swift
//  Backend Test
//
//  Created by CJ Wheelan on 1/10/21.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var error = ""
    
    @EnvironmentObject var session: SessionStore
    
    func signUp() {
        session.signUp(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        VStack {
            
            Text("Create Account")
                .font(.largeTitle)
                .bold()
            Text("Sign up to get started")
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
                
                
                
                Button(action: signUp, label: {
                    HStack {
                        Text("Sign Up!")
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
                }
                
                Spacer()
            }
            
        }
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(SessionStore())
    }
}
