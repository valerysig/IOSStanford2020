//
//  MemoryGame.swift
//  Memorize
//
//  Created by Valery Sigal on 15/08/2020.
//  Copyright © 2020 Valery Sigal. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    private var innerScore: Double
    private var firstCardPressed: Date?
    private var previouslyPressedCardIDs: Set<Int>
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUP }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUP = index == newValue
            }
            
        }
    }

    var score: Double {
        round(innerScore * 100) / 100
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        innerScore = 0
        previouslyPressedCardIDs = Set<Int>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        
        // Shuffle the cards
        cards = cards.shuffled()
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card),
        !cards[chosenIndex].isFaceUP,
        !cards[chosenIndex].isMatched {
            var willDecrease = true
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true

                    increaseScore()
                    willDecrease = false
                }
                self.cards[chosenIndex].isFaceUP = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                firstCardPressed = Date.init(timeIntervalSinceNow: 0)
            }

            if willDecrease {
                if previouslyPressedCardIDs.contains(cards[chosenIndex].id) {
                    decreaseScore()
                }
                previouslyPressedCardIDs.insert(cards[chosenIndex].id)
            }
        }
        print("card chosen: \(card), score: \(innerScore)")
    }

    private mutating func increaseScore() {
        // This value must never be null
        if let pressedCardSinceNow = firstCardPressed?.timeIntervalSinceNow {
            let scoreMultiplier = max(0, 10 + pressedCardSinceNow) / 10.0
            innerScore += 2 * scoreMultiplier
        }
//        score += 2
    }

    private mutating func decreaseScore() {
        innerScore -= 1
    }

    struct Card: Identifiable {
        var isFaceUP: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        
        var id : Int
    }
}
