//
//  ListView.swift
//  BBBrowser
//
//  Created by Andrew Rennard on 24/04/2021.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel = ListViewModel()
    
    
    var body: some View {
        if viewModel.refreshing {
            ProgressView(){
                Text("Loading…")
            }
        } else {
            TextField("Filter", text: $viewModel.filterText)
                .padding(5)
                .border(Color.init(.sRGB, white: 0.9, opacity: 1.0))
                .padding()
            Form {
                List(viewModel.filteredCharacters){ character in
                    NavigationLink(character.name, destination: Text("test"))
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
