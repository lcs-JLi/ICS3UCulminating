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
            
            if viewModel.isGameOver {
                Text("Congratulations! You won!")
                    .font(.title)
                    .foregroundColor(.green)
                    .padding()
                    .transition(.scale)
            }
            
            Text("Turns: \(viewModel.turnCount)")
                .font(.headline)
                .padding(.bottom)
            
            ScrollView {
                // We use a LazyVGrid to display the cards in a neat grid.
                LazyVGrid(columns: columns, spacing: 10) {
                    // We loop through the cards provided by the ViewModel.
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                // We wrap the choose function in withAnimation
                                // so that the changes (flipping and matching) are animated.
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    viewModel.choose(card)
                                }
                            }
                    }
                }
                .padding()
            }
            
            Button("New Game") {
                withAnimation {
                    viewModel.resetGame()
                }
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
        ZStack {
            // When face up or matched, show the front side.
            if card.isFaceUp || card.isMatched {
                ZExternalCardShape(isFaceUp: true, isMatched: card.isMatched) {
                    Text(card.content)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(5)
                }
            } else {
                // When face down, show the card back.
                ZExternalCardShape(isFaceUp: false, isMatched: card.isMatched) {
                    Text("?")
                        .font(.largeTitle)
                }
            }
        }
        // This modifier creates a 3D rotation effect.
        // We rotate by 180 degrees when face up or matched.
        .rotation3DEffect(
            .degrees(card.isFaceUp || card.isMatched ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
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
            
            if isFaceUp {
                // Layer the white background, the border, and the content.
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                // We flip the content back because the whole card was rotated 180 degrees.
                content.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
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
