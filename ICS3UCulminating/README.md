# Memory Game Overview

This project implements a classic card-matching memory game. The objective is to find and match all pairs of cards in the grid.

## How the Game Works

The game logic is managed by the `MemoryGame` structure. It handles a collection of `MemoryCard` objects, each containing a piece of content (such as an LCS House).

### The Matching Logic

1.  **Start:** All cards are shuffled and placed face-down.
2.  **First Flip:** When you tap a face-down card, it flips over.
3.  **Second Flip:** When you tap a second face-down card:
    *   If the content matches the first card, both cards stay face-up and are marked as "matched."
    *   If the content does not match, both cards will eventually flip back over when you start your next turn.
4.  **Completion:** The game ends when all cards are matched.

---

## Example Game Session

Imagine we have a small game with 2 pairs (4 cards total): **[A, B, A, B]** (shuffled).

### Initial State
*   Card 0: Face Down (A)
*   Card 1: Face Down (B)
*   Card 2: Face Down (A)
*   Card 3: Face Down (B)

### Turn 1
1.  **User chooses Card 0.**
    *   `indexOfAndOnlyFaceUpCard` was `nil`.
    *   Card 0 is flipped face-up.
    *   `indexOfAndOnlyFaceUpCard` becomes `0`.
2.  **User chooses Card 2.**
    *   `indexOfAndOnlyFaceUpCard` is `0`.
    *   The game compares Card 2 (A) with Card 0 (A).
    *   **Match Found!** Card 0 and Card 2 are marked `isMatched = true`.
    *   Card 2 is flipped face-up.

### Turn 2
1.  **User chooses Card 1.**
    *   `indexOfAndOnlyFaceUpCard` was `nil` (because two cards were already face up).
    *   Card 1 is flipped face-up.
    *   `indexOfAndOnlyFaceUpCard` becomes `1`.
2.  **User chooses Card 3.**
    *   `indexOfAndOnlyFaceUpCard` is `1`.
    *   The game compares Card 3 (B) with Card 1 (B).
    *   **Match Found!** Card 1 and Card 3 are marked `isMatched = true`.
    *   Card 3 is flipped face-up.

### Game Over
All cards are matched and face-up.
