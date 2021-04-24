//
//  ListViewModel.swift
//  BBBrowser
//
//  Created by Andrew Rennard on 24/04/2021.
//

import Foundation
import Combine

struct FetchError: Identifiable {
    var id = UUID()
    var error: Error
}

class ListViewModel: ObservableObject {
    @Published var fetchError: FetchError? = nil
    @Published var refreshing: Bool = false
    @Published var filterText: String = ""

    let apiClient: APIClientProtocol
    private var subscriptions: [AnyCancellable] = []

    var characters: [BreakingBadCharacter] = []
    var filteredCharacters: [BreakingBadCharacter] {
        guard filterText.count > 0 else { return characters }
        return characters.filter{ $0.name.lowercased().contains(filterText.lowercased())}
    }
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
        fetchCharacters()
    }
    
    func fetchCharacters() {
        refreshing = true
        let publisher: AnyPublisher<[BreakingBadCharacter], Error> = apiClient.get(BreakingBadAPI.characters.url)
        publisher.sink { completion in
            if case .failure(let error) = completion {
                self.fetchError = FetchError(error: error)
            }
            self.refreshing = false
        } receiveValue: { (model: [BreakingBadCharacter]) in
            self.refreshing = false
            self.characters = model.sorted{ $0.name < $1.name }
        }.store(in: &subscriptions)
    }
}