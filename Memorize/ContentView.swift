//
//  ContentView.swift
//  Memorize
//
//  Created by Thach Huynh on 23/12/2023.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["👁️","👻","🍍","👽","😂","☹️","😀","🥹","🤬","😋","🤓"]
    @State var cardCount = 4
    var body: some View {
        VStack {
            ScrollView{
                cards
            }
            
            Spacer()
            cardCountAdjuster
        }.padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum:120))]){
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3,contentMode: .fit)
            }
        }.foregroundColor(.orange)
    }
    var cardCountAdjuster: some View {
        HStack {
            cardAcountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
            Spacer()
            cardAcountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
        }.imageScale(.large)
            .font(.largeTitle)
    }
    func cardAcountAdjuster(by: Int, symbol: String) -> some View {
        Button(action: {
            cardCount+=by
            
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + by < 1 || cardCount + by > emojis.count)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack(content: {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base
                    .foregroundColor(.white)
                base
                    .strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            
            base
                .foregroundColor(.orange).opacity(isFaceUp ? 0 : 1)
        }).onTapGesture {
            isFaceUp.toggle()
        }
       
    }
}

#Preview {
    ContentView()
}
