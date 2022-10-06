//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Daffolapmac-155 on 29/09/22.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia","France", "Germany","Ireland","Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US" ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreCount = 0
    @State private var endGame = false
    
    var body: some View{
        ZStack{
            
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                                   .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),], center: .top, startRadius: 200, endRadius: 400)
            
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing:15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary).font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer]).font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                        .alert("Restart Game", isPresented: $endGame, actions: {
                            Button("OK") {
                                scoreCount = 0
                                askQuestion()
                            }
                        })
                        .alert(scoreTitle, isPresented: $showingScore) {
                            Button("Continue", action: askQuestion)
                            //here we are not setting showingScore to false because when askQuestion is executed the struct is constructed again due to change in state property.
                        } message: {
                            
                                if scoreTitle == "Wrong"{
                                    Text("That's the flag of \(countries[number]).\n Your score is \(scoreCount)")
                                }
                                Text("Your score is \(scoreCount)")
                            
                        }

                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(scoreCount)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()

            
            
        }

     
    }
    // for checking the answer
    func flagTapped(_ number: Int) {
        if number == correctAnswer{
            scoreTitle = "Correct"
            scoreCount += 1
        }else{
            scoreTitle = "Wrong"
            scoreCount -= 1

        }
        showingScore = true
        if scoreCount == 8{
            endGame = true
            showingScore = false
        }
    }
    // for keep playing the game
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                
        }
    }
}
