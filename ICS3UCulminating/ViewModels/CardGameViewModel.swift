//
//  HouseListViewModel.swift
//  ICS3UCulminating
//
//  Created by Xichen Li on 6/1/26.
//

import SwiftUI
internal import Combine

class CardMemoryGame: ObservableObject {
    // Shared data source for the game
    private static let cardContents = ["A", "K", "Q", "J", "10", "9","8","7"]
    
    // Factory method to initialize a fresh game model
    private static func createMemoryGame() -> MemoryGame {
        MemoryGame(numberOfPairsOfCards: cardContents.count) { pairIndex in
            cardContents[pairIndex]
        }
    }
    
    // The single source of truth for the game state
    @Published private var model = createMemoryGame()
    
    // Expose the cards safely to the View
    var cards: [Card] {
        model.cards
    }
    
    // MARK: - User Intents
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func resetGame() {
        model = CardMemoryGame.createMemoryGame()
    }
}
