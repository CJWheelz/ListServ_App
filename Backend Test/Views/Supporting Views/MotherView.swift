//
//  MotherView.swift
//  Backend Test
//
//  Created by CJ Wheelan on 1/10/21.
//

import SwiftUI

struct MotherView: View {
    
    @EnvironmentObject var session: SessionStore
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        Group {
            if (session.session != nil) {
                TabIconView()
            } else {
                SignInView()
            }
        }.onAppear(perform: getUser)
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(SessionStore())
    }
}
