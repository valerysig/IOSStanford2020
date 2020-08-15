//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Valery Sigal on 15/08/2020.
//  Copyright © 2020 Valery Sigal. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intents
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    // MARK: - Static Methods
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🕷", "☠️", "👽", "😈", "👹", "🤖", "👁", "👣", "🦂", "🦑"].shuffle()
        let numberOfPairs = Int.random(in: 2...5)
        
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { pairIndex in
            emojis[pairIndex]
        }
    }
}
