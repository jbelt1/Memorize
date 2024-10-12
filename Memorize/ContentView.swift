//
//  ContentView.swift
//  Memorize
//
//  Created by Jeffrey Belt III on 10/10/24.
//

import SwiftUI

let animals = ["🐶","🐶","🐱","🐱","🐻","🐻","🦊","🦊", "🐸", "🐸", "🐰", "🐰"]
let flowers = ["🌸","🌸","🌼","🌼","🌺","🌺","🌻","🌻"]
let food = ["🍔","🍔","🌮","🌮","🍟","🍟","🍕","🍕","🍗","🍗","🌯","🌯","🥪","🥪","🥨","🥨","🥞","🥞","🧀","🧀"]

struct ContentView: View {
    
    var themeMap =
        ["Animals": animals,
         "Flowers": flowers,
         "Food": food
        ]
    
    @State var currentEmojis: [String] = animals
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeSelectors
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
            let cards = currentEmojis.shuffled()
            ForEach(0..<cards.count, id: \.self) {
                CardView(content: cards[$0])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var themeSelectors: some View {
        HStack(spacing: 40) {
            Spacer()
            animalsSelector
            flowersSelector
            foodSelector
            Spacer()
        }
        .imageScale(.large)
        
    }
    
    func createThemeSelector(theme: String, symbol: String) -> some View {
        Button(action: {
            currentEmojis = themeMap[theme] ?? []
        }, label: {
            VStack {
                Image(systemName: symbol)
                Text(theme)
            }
        })
    }
    
    var animalsSelector: some View {
        createThemeSelector(theme: "Animals", symbol: "dog.fill")
    }
    
    var flowersSelector: some View {
        createThemeSelector(theme: "Flowers", symbol: "sun.max.fill")
    }
    
    var foodSelector: some View {
        createThemeSelector(theme: "Food", symbol: "takeoutbag.and.cup.and.straw.fill")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
