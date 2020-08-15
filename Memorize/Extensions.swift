//
//  Extensions.swift
//  Memorize
//
//  Created by Valery Sigal on 15/08/2020.
//  Copyright © 2020 Valery Sigal. All rights reserved.
//

import Foundation

extension Array where Element: Any {
    func shuffle() -> Array<Element>{
        var currentArray = self
        var shuffledResult = Array<Element>()
        
        while !currentArray.isEmpty {
            let currentIndex = Int.random(in: 0..<currentArray.count)
            let currentCard = currentArray.remove(at: currentIndex)
            shuffledResult.append(currentCard)
        }
        
        return shuffledResult
    }
}
