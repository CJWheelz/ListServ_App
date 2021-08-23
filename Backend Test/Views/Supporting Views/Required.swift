//
//  Required.swift
//  Backend Test
//
//  Created by CJ Wheelan on 5/7/21.
//

import SwiftUI

struct Required: View {
    
    var header : String
    
    var body: some View {
        HStack {
            Text(header)
            Image(systemName: "staroflife.fill")
                .foregroundColor(Color.red)
        }
    }
}

struct Required_Previews: PreviewProvider {
    static var previews: some View {
        Required(header: "Add an Image")
    }
}
