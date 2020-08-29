//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Valery Sigal on 15/08/2020.
//  Copyright © 2020 Valery Sigal. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let EMOJI_THEME : [(name: String, cardsCount: Int, cardsColor: UIColor, emojis: [String])] = [
        (name: "Halloween", cardsCount: Int.random(in: 2...5), cardsColor: UIColor.orange, emojis: ["👻", "🎃", "🕷", "☠️", "👽", "😈", "👹", "🤖", "👁", "👣", "🦂", "🦑"]),
        (name: "Transportation", cardsCount: Int.random(in: 2...5), cardsColor: UIColor.blue, emojis: ["🚗", "🚕", "🚙", "🚌", "🏎", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛", "🛵"]),
        (name: "People", cardsCount: 12, cardsColor: UIColor.brown, emojis:["👩‍🦳", "👲", "👮", "👷️", "💂️", "🕵🏻‍️", "👩‍🌾", "👩‍🍳", "👩‍🎓", "👩‍🎤", "👨‍🎤", "👩‍💻"]),
        (name: "Animals", cardsCount: 10, cardsColor: UIColor.green, emojis:["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐸", "🐵", "🐤", "🐔"]),
        (name: "Weather", cardsCount: 8, cardsColor: UIColor.yellow, emojis:["☃️", "❄️", "🌨", "🌩", "☀️", "🌈", "🌪", "💫", "✨", "🌬", "💧", "☔️"]),
        (name: "Fruits and vegetables", cardsCount: 12, cardsColor: UIColor.red, emojis:["🍏", "🍎", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍒", "🥦", "🌶", "🥕"])
    ]
    
    @Published private var model: MemoryGame<String>!
    @Published private(set) var themeName: String!
    @Published private(set) var themeColor: UIColor!
    @Published private(set) var themeColorGradient: RadialGradient!

    init() {
        self.clear()
    }

    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }

    var score: String {
        String(model.score)
    }
    
    // MARK: - Intents
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }

    func clear() {
        let modelAndTheme = EmojiMemoryGame.createMemoryGame()
        self.model = modelAndTheme.0
        self.themeName = modelAndTheme.1
        self.themeColor = modelAndTheme.2
        self.themeColorGradient = RadialGradient(gradient: Gradient(colors: [.white, Color(self.themeColor)]),
                center: .center,
                startRadius: 1,
                endRadius: 100)
    }
    
    // MARK: - Static Methods
    static func createMemoryGame() -> (MemoryGame<String>, String, UIColor) {
        // Theme: Theme name, Emoji sets, Number of cards to show, back color for cards
        let emojiTheme = EMOJI_THEME[Int.random(in: 0..<EMOJI_THEME.count)]
        let emojis = emojiTheme.emojis.shuffled()
        let numberOfPairs = emojiTheme.cardsCount

        return (MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { emojis[$0] },
                emojiTheme.name,
                emojiTheme.cardsColor
        )
    }
}
