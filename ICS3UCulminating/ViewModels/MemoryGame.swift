//
//  MemoryGame.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 6/2/26.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    // MARK: - Stored properties
    
    // The collection of cards in the game
    private(set) var cards: [MemoryCard<CardContent>]
    
    // Tracks the number of turns taken (one turn = flipping two cards)
    private(set) var turnCount: Int = 0
    
    // MARK: - Computed properties
    
    // Checks if every card in the deck has been matched.
    var allCardsMatched: Bool {
        for card in cards {
            if card.isMatched == false {
                return false
            }
        }
        return true
    }
    
    // The index of the only card that is currently face up (if any)
    private var indexOfAndOnlyFaceUpCard: Int? {
        get {
            var faceUpIndices: [Int] = []
            for index in 0..<cards.count {
                if cards[index].isFaceUp {
                    faceUpIndices.append(index)
                }
            }
            
            if faceUpIndices.count == 1 {
                return faceUpIndices[0]
            } else {
                return nil
            }
        }
        set {
            for index in 0..<cards.count {
                if index == newValue {
                    cards[index].isFaceUp = true
                } else {
                    cards[index].isFaceUp = false
                }
            }
        }
    }
    
    // MARK: - Initializer
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // Add numberOfPairsOfCards * 2 cards to the cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(MemoryCard(content: content))
            cards.append(MemoryCard(content: content))
        }
        
        // Shuffle the cards
        cards.shuffle()
    }
    
    // MARK: - Functions
    
    mutating func choose(_ card: MemoryCard<CardContent>) {
        // Find the index of the chosen card
        var chosenIndex: Int? = nil
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                chosenIndex = index
                break
            }
        }
        
        // If the card exists, is not face up, and is not matched
        if let chosenIndex = chosenIndex,
           cards[chosenIndex].isFaceUp == false,
           cards[chosenIndex].isMatched == false {
            
            // Check if there is already one card face up
            if let potentialMatchIndex = indexOfAndOnlyFaceUpCard {
                
                // Increment the turn count because the user has now flipped a pair.
                turnCount += 1
                
                // Check if the chosen card matches the face-up card
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                // Either 0 or 2 cards are face up, so start a new turn
                indexOfAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
}
