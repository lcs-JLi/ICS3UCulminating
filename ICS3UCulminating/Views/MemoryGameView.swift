//
//  MemoryGameView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 6/2/26.
//

import SwiftUI

struct MemoryGameView: View {
    
    // MARK: - Stored properties
    
    // The View owns an instance of the ViewModel.
    // Because it's @Observable, we don't need @StateObject or @ObservedObject.
    var viewModel: MemoryGameViewModel = MemoryGameViewModel()
    
    // Define the grid layout: 4 columns for a better fit with 16 cards.
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: - View Body
    
    var body: some View {
        VStack {
            Text("Card Rank Memory")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            ScrollView {
                // We use a LazyVGrid to display the cards in a neat grid.
                LazyVGrid(columns: columns, spacing: 10) {
                    // We loop through the cards provided by the ViewModel.
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                // When a card is tapped, we tell the ViewModel to "choose" it.
                                viewModel.choose(card)
                            }
                    }
                }
                .padding()
            }
            
            Button("New Game") {
                viewModel.resetGame()
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
    }
}

// A sub-view specifically for drawing a single card.
struct CardView: View {
    let card: MemoryCard<String>
    
    var body: some View {
        ZExternalCardShape(isFaceUp: card.isFaceUp, isMatched: card.isMatched) {
            // If the card is face up, show the rank.
            if card.isFaceUp || card.isMatched {
                Text(card.content)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(5)
            } else {
                // If face down, show a placeholder.
                Text("?")
                    .font(.largeTitle)
            }
        }
    }
}

// A helper view to draw the card background and border.
struct ZExternalCardShape<Content: View>: View {
    let isFaceUp: Bool
    let isMatched: Bool
    let content: Content
    
    // Explicit initializer with @ViewBuilder to allow multiple views in the closure.
    init(isFaceUp: Bool, isMatched: Bool, @ViewBuilder content: () -> Content) {
        self.isFaceUp = isFaceUp
        self.isMatched = isMatched
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            
            if isFaceUp || isMatched {
                // Layer the white background, the border, and the content.
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                content
            } else {
                // Show the card back.
                shape.fill(.red)
            }
        }
        // Make matched cards slightly transparent to show they are "done".
        .opacity(isMatched ? 0.4 : 1.0)
    }
}

#Preview {
    MemoryGameView()
}
