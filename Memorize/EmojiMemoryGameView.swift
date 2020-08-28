//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Valery Sigal on 15/08/2020.
//  Copyright © 2020 Valery Sigal. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            CardsGridView(viewModel: viewModel)
            Button(action: {
                self.viewModel.clear()
            }) {
                Text("New Game")
                        .bold()
                        .foregroundColor(.black)
                        .background(Color(self.viewModel.themeColor))
            }
        }
    }
}

struct CardsGridView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        Grid(viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                        self.viewModel.choose(card: card)
                    }
                    .padding(5)
        }
                .padding()
                .foregroundColor(Color(viewModel.themeColor))
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if self.card.isFaceUP {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing constants
    let cornerRadius = CGFloat(10)
    let edgeLineWidth = CGFloat(3)
    let fontScaleFactor = CGFloat(0.75)
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

// MARK: Glue the SwiftUI to the view
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
