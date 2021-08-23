//
//  FilterView.swift
//  Backend Test
//
//  Created by CJ Wheelan on 2/20/21.
//

import SwiftUI

struct FilterView: View {
    
    @Binding var filterViewIsShown : Bool
    @Binding var categoryChoice : String
    @Binding var sortChoice : String
    
    static let categories = ["All", "ISO (In Search Of)", "FS (For Sale)", "Advertisements", "Lost and Found", "Announcements", "Other"]
    
    static let sortChoices = ["Newest Posts First (default)", "Oldest Posts First"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Filter by Category"), content: {
                        Picker("Filter", selection: $categoryChoice) {
                            ForEach(FilterView.categories, id: \.self) { category in
                                Text(category)
                            }
                        }
                    })
                    
                    Section(header: Text("Sort by Time Posted")) {
                        Picker("Sort", selection: $sortChoice) {
                            ForEach(FilterView.sortChoices, id: \.self) { choice in
                                Text(choice)
                            }
                        }.labelsHidden()
                    }
                }
            }.navigationTitle("Search Settings")
            .navigationBarItems(trailing: Button("Done") {
                filterViewIsShown.toggle()
            })
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(filterViewIsShown: Binding.constant(true), categoryChoice: Binding.constant(""), sortChoice: Binding.constant("Newest Posts First (default)"))
    }
}
