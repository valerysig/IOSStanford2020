//
//  ContentView.swift
//  Memorize
//
//  Created by Valery Sigal on 15/08/2020.
//  Copyright © 2020 Valery Sigal. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            ForEach(0..<4) { index in
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                    RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                    Text("👻")
                }
            }
        }
            .padding()
            .foregroundColor(Color.orange)
            .font(Font.largeTitle)
    }
}

// MARK: Glue the SwiftUI to the view
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
