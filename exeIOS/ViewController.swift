//
//  ViewController.swift
//  exeIOS
//
//  Created by Student18 on 24/06/2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var player1Card: UIImageView!
    @IBOutlet weak var player2Card: UIImageView!
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player2ScoreLabel: UILabel!
    
        var player1Score = 0
        var player2Score = 0
        var timer: Timer?
        var showingReversedCard = true

        enum RPS: String {
            case rock = "rock"
            case paper = "paper"
            case scissors = "scissors"
            case backCard = "backCard"
            
            static func random() -> RPS {
                let options: [RPS] = [.rock, .paper, .scissors]
                return options.randomElement()!
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            resetGame()
            startAutomaticCardDrawing()
        }
        
        func resetGame() {
            player1Score = 0
            player2Score = 0
            updateUI()
        }
        
        func updateUI() {
            player1ScoreLabel.text = "\(player1Score)"
            player2ScoreLabel.text = "\(player2Score)"
            player1Card.image = UIImage(named: RPS.backCard.rawValue)
            player2Card.image = UIImage(named: RPS.backCard.rawValue)
        }
        
        func determineWinner(player1Choice: RPS, player2Choice: RPS) -> Int {
            switch (player1Choice, player2Choice) {
            case (.rock, .scissors), (.scissors, .paper), (.paper, .rock):
                return 1 // Player 1 wins
            case (.scissors, .rock), (.paper, .scissors), (.rock, .paper):
                return 2 // Player 2 wins
            default:
                return 0 // Tie
            }
        }
        
        func startAutomaticCardDrawing() {
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(handleCardDrawing), userInfo: nil, repeats: true)
        }
        
        @objc func handleCardDrawing() {
            if showingReversedCard {
                player1Card.image = UIImage(named: RPS.backCard.rawValue)
                player2Card.image = UIImage(named: RPS.backCard.rawValue)
                showingReversedCard = false
            } else {
                let player1Choice = RPS.random()
                let player2Choice = RPS.random()
                
                player1Card.image = UIImage(named: player1Choice.rawValue)
                player2Card.image = UIImage(named: player2Choice.rawValue)
                
                let winner = determineWinner(player1Choice: player1Choice, player2Choice: player2Choice)
                
                if winner == 1 {
                    player1Score += 1
                } else if winner == 2 {
                    player2Score += 1
                }
                
                updateUI()
                showingReversedCard = true
            }
        }
        
        deinit {
            timer?.invalidate()
        }
    }
