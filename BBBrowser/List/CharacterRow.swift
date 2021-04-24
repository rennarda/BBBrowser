//
//  CharacterRow.swift
//  BBBrowser
//
//  Created by Andrew Rennard on 24/04/2021.
//

import SwiftUI

struct CharacterRow: View {
    let character: BreakingBadCharacter
    var body: some View {
        HStack{
            URLImage(url: character.imageURL)
                .frame(width: 40, height: 40)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(3)
            Text(character.name)
        }
    }
    
    init(_ character: BreakingBadCharacter){
        self.character = character
    }
}
