//
//  MemoryCard.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 6/2/26.
//

import Foundation

// This structure represents a single card in the memory game.
// It is generic, meaning it can hold any type of content (like a House or a String).
struct MemoryCard<CardContent>: Identifiable {
    
    // MARK: - Stored properties
    
    // A unique ID so SwiftUI can tell cards apart, even if they have the same content.
    let id = UUID()
    
    // This boolean tracks if the card is currently showing its content (face up)
    // or showing its back (face down).
    var isFaceUp: Bool = false
    
    // This boolean tracks if the card has already been matched with its pair.
    // Matched cards usually stay face up and are no longer interactive.
    var isMatched: Bool = false
    
    // This property holds the actual data for the card (e.g., a House instance).
    let content: CardContent
}
