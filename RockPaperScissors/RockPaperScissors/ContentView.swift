//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Zheen Suseyi on 10/3/24.
//

/*
 Challenge
 You have a basic understanding of arrays, state, views, images, text, and more, so let’s put them together: your challenge is to make a brain training game that challenges players to win or lose at rock, paper, scissors.

 So, very roughly:

 Each turn of the game the app will randomly pick either rock, paper, or scissors.
 Each turn the app will alternate between prompting the player to win or lose.
 The player must then tap the correct move to win or lose the game.
 If they are correct they score a point; otherwise they lose a point.
 The game ends after 10 questions, at which point their score is shown.
 So, if the app chose “Rock” and “Win” the player would need to choose “Paper”, but if the app chose “Rock” and “Lose” the player would need to choose “Scissors”.


 */
import SwiftUI

struct ContentView: View {
    // Array for our choices for the game, rock paper or scissors
    @State private var gameArr = ["rock1", "paper1", "scissors1"]
    // Tracking user score
    @State private var userScore = 0
    // Tracking number of questions
    @State private var questionNum = 1
    // What our opponent (the fox) is gonna throw each turn
    @State private var opponentThrows = Int.random(in: 0...2)
    // For displaying our score
    @State private var scoreTitle = ""
    // For activating our alert
    @State private var showingScore = false
    // For when the game needs to get restarted this gets activated
    @State private var showFinalAlert = false
    
    var body: some View {
        // Our ZStack AKA the background!
        ZStack{
            Image("coyotevswolf2")
                // getting the image to fit the entire screen
                .resizable()
                .ignoresSafeArea()
                
                // Alert for when the user plays a round
                .alert(scoreTitle, isPresented: $showingScore) {
                    Button("Continue", action: askQuestion)
                    }message: {
                    Text("Your score is \(userScore)")
                }
                
                // Alert for when user plays the final round
                .alert("Game Over", isPresented: $showFinalAlert) {
                    Button("Restart?", action: resetGame)
                    } message: {
                    Text("You played all 10 rounds, your final score is: \(userScore).")
                    }
            // VStack #1 for the two text boxes up top
            VStack {
                    Text("Hello! Can you beat the Fox?")
                        // Modifiers for our text
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    
                    Text("SCORE: \(userScore)")
                        // Modifiers for our text
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Spacer()
                
                // VStack #2 for the bright red text
                VStack{
                    
                    Text("Choose Rock, Paper, or Scissors")
                        // Modifiers for our text
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                    // VStack #3 that will display the users choices for either rock, paper, or scissors
                    VStack {
                    // loops from 0-2
                    ForEach(0..<3) { number in
                        Button {
                            // calls our movetapped function
                            moveTapped(number)
                            // Displays the images for rock, paper, and scissors
                        } label: {
                            Image(gameArr[number])
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                            }
                        Spacer()
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    // moveTapped function, can probably be made way more efficient, takes a number (user choice of rock, paper, or scissors) as a parameter
    func moveTapped(_ number: Int) {
        // if the fox throws Scissors then the following might happen depending on what the user picked
        if opponentThrows == 2 {
            if number == 0 {
                scoreTitle = "The Fox threw Scissors! You win this round by throwing Rock!"
                userScore += 1
            }
            else if number == 1 {
                scoreTitle = "The Fox threw Scissors! You lose this round by throwing Paper!"
                userScore -= 1
            }
            else if number == 2 {
                scoreTitle = "The Fox threw Scissors! You Tie this round by throwing the same thing!"
                userScore += 0
            }
        }
        // if the fox throws Paper then the following might happen depending on what the user picked
        else if opponentThrows == 1 {
            if number == 0 {
                scoreTitle = "The Fox threw Paper! You lose this round by throwing Rock!"
                userScore -= 1
            }
            else if number == 1 {
                scoreTitle = "The Fox threw Paper! You tie this round by throwing Paper!"
                userScore += 0
            }
            else if number == 2 {
                scoreTitle = "The Fox threw Paper! You win this round by throwing Scissors!"
                userScore += 1
            }
        }
        // if the fox throws Rock then the following might happen depending on what the user picked
        else if opponentThrows == 0 {
            if number == 0 {
                scoreTitle = "The Fox threw Rock! You tie this round by throwing Rock!"
                userScore += 0
            }
            else if number == 1 {
                scoreTitle = "The Fox threw Rock! You lose this round by throwing Paper!"
                userScore += 1
            }
            else if number == 2 {
                scoreTitle = "The Fox threw Rock! You lose this round by throwing Scissors!"
                userScore -= 1
            }
        }
        else {
        }
        showingScore = true
    }
    
    
    // Function for proceeding onto the next round, gives the Fox the ability to pick a choice at random
    func askQuestion() {
        // If our counter does not equal 10, then proceed with game
        if questionNum != 10{
            opponentThrows = Int.random(in: 0...2)
            questionNum += 1
        }
        
        // Otherwise, just show the final alert
        else {
            showFinalAlert = true  // Show the game over alert
        }
    }
    
    // Function that will be called once showFinalAlert = true, this will restart the game
    func resetGame() {
        questionNum = 1
        userScore = 0
        opponentThrows = Int.random(in: 0...2)
    }
}


#Preview {
    ContentView()
}
