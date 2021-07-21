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
        VStack(spacing: 10) {
            Text(character.name)
                .font(.largeTitle)
                .fontWeight(.heavy)

            Text(character.nickname)
                .font(.title)
                .italic()
                .foregroundColor(.secondary)

            URLImage(url: character.imageURL)
                .aspectRatio(contentMode: .fill)
                .border(Color.white, width: 5)
                .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 3)
                .rotationEffect(Angle(degrees: Double.random(in: -5...5)))
                .padding(50)

            Text(character.occupation.joined(separator: ",\n"))
                .font(.subheadline)

            HStack {
                Text("Status:")
                Text(character.status).fontWeight(.bold)
            }

            Text("Seasons: " + character.episodeAppearances
                    .map{"\($0)"}
                    .joined(separator: ", "))

            Spacer()
        }
        .padding()
        .multilineTextAlignment(.center)

    }

    init(_ character: BreakingBadCharacter) {
        self.character = character
    }

}
