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
    
    // This is the actual game logic instance.
    // It's private because we want the View to go through the ViewModel to change things.
    private var model: MemoryGame<House>
    
    // MARK: - Computed properties
    
    // This allows the View to see the cards, but not change them directly.
    var cards: [MemoryCard<House>] {
        return model.cards
    }
    
    // MARK: - Initializer
    
    init() {
        // We initialize the game with a factory function that provides Houses.
        // For this example, we'll use the first 6 houses from our example list.
        model = MemoryGame<House>(numberOfPairsOfCards: 6) { pairIndex in
            return exampleHouseList[pairIndex]
        }
    }
    
    // MARK: - Functions
    
    // This is the "intent" function. When a user taps a card in the View,
    // the View calls this function to tell the Model what happened.
    func choose(_ card: MemoryCard<House>) {
        model.choose(card)
    }
    
    // A helper function to start a fresh game.
    func resetGame() {
        model = MemoryGame<House>(numberOfPairsOfCards: 6) { pairIndex in
            return exampleHouseList[pairIndex]
        }
    }
}
