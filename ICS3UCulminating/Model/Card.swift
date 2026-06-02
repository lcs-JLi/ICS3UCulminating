//
//  House.swift
//  ICS3UCulminating
//
//  Created by Xichen Li on 6/1/26.
//

import Foundation

// MODEL
struct Card: Identifiable {
    
    // MARK: Stored properties
    // Stored properties must be provided with a value by providing an argument when creating an instance of this structure, or, be initialized with a default value
    
    // Unique identifier to conform to Identifiable protocol
    // This is initialized with a default value
    let id = UUID()

    //Card facing up or down
    var isFaceUp: Bool = false
    
    //Cards matched or not
    var isMatched: Bool = false
    
    //Name of the card
    var content: String
    
    // MARK: Computed properties
    // Computed properties calculate or derive a value using stored properties
    
    // MARK: Functions
    // Functions take action using information provided through parameters

}


struct MemoryGame {
    private(set) var cards: Array<Card>
    
    mutating func choose(_ card: Card) {
        // This is where your core logic will go:
        // 1. Find the chosen card in the array
        // 2. Check if another card is already face up
        // 3. If yes, compare them for a match
        // 4. If no, just flip this one face up
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> String) {
        cards = []
        // Add pairs of cards to the array and shuffle them
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        cards.shuffle()
    }
}
