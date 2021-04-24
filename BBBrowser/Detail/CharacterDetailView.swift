//
//  CharacterDetailView.swift
//  BBBrowser
//
//  Created by Andrew Rennard on 24/04/2021.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: BreakingBadCharacter

    var body: some View {
        Text(character.name)
    }

    init(_ character: BreakingBadCharacter) {
        self.character = character
    }

}
