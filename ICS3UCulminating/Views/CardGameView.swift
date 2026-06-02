//
//  HousesListView.swift
//  ICS3UCulminating
//
//  Created by Xichen Li on 6/1/26.
//

import SwiftUI

struct ContentView: View {
    // @StateObject creates and owns the ViewModel lifecycle for this screen
    @StateObject private var gameViewModel = CardMemoryGame()
    
    var body: some View {
        VStack {
            Text("Memory Match")
                .font(.largeTitle)
                .bold()
                .padding()
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(gameViewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    gameViewModel.choose(card)
                                }
                            }
                    }
                }
            }
            .padding(.horizontal)
            
            Button("New Game") {
                withAnimation {
                    gameViewModel.resetGame()
                }
            }
            .font(.headline)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

// A subview responsible only for rendering a individual card state
struct CardView: View {
    let card: Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 12)
            
            if card.isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(.blue, lineWidth: 3)
                Text(card.content)
                    .font(.system(size: 32, weight: .bold))
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill(.blue)
            }
        }
        .rotation3DEffect(
            Angle.degrees(card.isFaceUp ? 0 : 180),
            axis: (x: 0, y: 1, z: 0)
        )
    }
}

#Preview {
    ContentView()
}
