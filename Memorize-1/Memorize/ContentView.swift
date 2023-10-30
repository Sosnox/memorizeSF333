import SwiftUI

struct ContentView: View {
    let emojis_animal = ["🐵", "🦊", "🐶", "🦁", "🐯", "🐱", "🐎", "🐷"] + ["🐵", "🦊", "🐶", "🦁", "🐯", "🐱", "🐎", "🐷"]
    let emojis_car = ["🏎️", "🚌", "🚍", "🚎", "🚐", "🚑", "🚒", "🚓"] + ["🏎️", "🚌", "🚍", "🚎", "🚐", "🚑", "🚒", "🚓"]
    let emojis_kugkoo = ["👻", "🎃", "🕷️", "👹", "💀", "🕸️", "🧙", "🙀"] + ["👻", "🎃", "🕷️", "👹", "💀", "🕸️", "🧙", "🙀"]
    let cardCount = 16

    @State var emojis_choosed: [String]

    init() {
        self.emojis_choosed = emojis_animal.shuffled()
    }

    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.pink)
                .padding(.bottom, 10)
            
            ScrollView {
                cards
            }
            cardCountAdjusters
        }
        .padding()
        .onChange(of: emojis_choosed) { newValue in
            if newValue.count >= cardCount {
                emojis_choosed.shuffle()
            }
                    }
    }
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                if index < emojis_choosed.count {}
                CardView(content: emojis_choosed[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }

    var cardCountAdjusters: some View {
        HStack(spacing : 40){
            Button(action: {
                emojis_choosed = emojis_animal
            }) {
                VStack {
                    Image(systemName: "flame")
                        .frame(width: 10, height: 10)
                    Text("Animal").font(.title)
                }
            }
            Button(action: {
                emojis_choosed = emojis_car
            }) {
                VStack {
                    Image(systemName: "car")
                        .frame(width: 10, height: 10)
                    Text("Car").font(.title)
                }
            }
            Button(action: {
                emojis_choosed = emojis_kugkoo
            }) {
                VStack {
                    Image(systemName: "face.smiling")
                        .frame(width: 10, height: 10)
                    Text("Kugkoo").font(.title)
                }
            }
        }
        .imageScale(.large)
        .font(.largeTitle)
        .frame(height: 100)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}