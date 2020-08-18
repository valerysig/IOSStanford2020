//
//  Array+Only.swift
//  Memorize
//
//  Created by Valery Sigal on 18/08/2020.
//  Copyright © 2020 Valery Sigal. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
