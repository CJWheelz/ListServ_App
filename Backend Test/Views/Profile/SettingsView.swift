//
//  SettingsView.swift
//  Backend Test
//
//  Created by CJ Wheelan on 1/10/21.
//

import SwiftUI
import Firebase

struct SettingsView: View {
    
    @EnvironmentObject var session: SessionStore
    
    let user = (Auth.auth().currentUser?.email)!
    
    var body: some View {
        VStack {
            Text(user)
            
            Button(action: session.signOut) {
                Text("Sign Out")
            }
        }.accentColor(Color.blue)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(SessionStore())
    }
}
