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
        NavigationView {
            if viewModel.refreshing {
                ProgressView(){
                    Text("Loading…")
                }
            } else if viewModel.fetchError != nil {
                VStack(spacing: 30) {
                    Text("Unable to load characters")
                    Button {
                        viewModel.fetchCharacters()
                    } label: {
                        Text("Retry")
                    }
                }
            } else {
                VStack {
                    TextField("Filter", text: $viewModel.filterText)
                        .padding(5)
                        .border(Color.init(.sRGB, white: 0.9, opacity: 1.0))
                        .padding()
                    HStack {
                        Text("Series: ")
                        Picker(selection: $viewModel.seriesFilter, label: Text("Series")) {
                            Text("All").tag(0)
                            Text("1").tag(1)
                            Text("2").tag(2)
                            Text("3").tag(3)
                            Text("4").tag(4)
                            Text("5").tag(5)
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    .padding()
                    
                    List(viewModel.filteredCharacters){ character in
                        NavigationLink(destination: CharacterDetailView(character)) {
                            CharacterRow(character)
                        }
                    }
                }.navigationTitle("Characters")
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
