//
//  MemoryGameViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 6/2/26.
//

import Foundation

// The ViewModel is the "manager" that connects the Model (logic) to the View (UI).
// We use @Observable so that SwiftUI automatically updates the screen when the game state changes.
@Observable
class MemoryGameViewModel {
    
    // MARK: - Stored properties
    
    // The list of card ranks used for the game.
    // We make this 'static' so it can be accessed without needing an instance of the class.
    private static let cardRanks: [String] = ["A", "K", "Q", "J", "10", "9", "8", "7"]
    
    // This is the actual game logic instance.
    // It's private because we want the View to go through the ViewModel to change things.
    // We are now using String for the card content.
    private var model: MemoryGame<String>
    
    // MARK: - Computed properties
    
    // This allows the View to see the cards, but not change them directly.
    var cards: [MemoryCard<String>] {
        return model.cards
    }
    
    // MARK: - Initializer
    
    init() {
        // We initialize the game with 8 pairs of cards using our cardRanks array.
        // We use 'MemoryGameViewModel.cardRanks' to access the static property.
        model = MemoryGame<String>(numberOfPairsOfCards: 8) { pairIndex in
            return MemoryGameViewModel.cardRanks[pairIndex]
        }
    }
    
    // MARK: - Functions
    
    // This is the "intent" function. When a user taps a card in the View,
    // the View calls this function to tell the Model what happened.
    func choose(_ card: MemoryCard<String>) {
        model.choose(card)
    }
    
    // A helper function to start a fresh game.
    func resetGame() {
        model = MemoryGame<String>(numberOfPairsOfCards: 8) { pairIndex in
            return MemoryGameViewModel.cardRanks[pairIndex]
        }
    }
}
