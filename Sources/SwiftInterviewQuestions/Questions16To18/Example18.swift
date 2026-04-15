enum Question18 {
    static func run() {        
        let game = Game()
        while game.isOngoing() {
            game.play()
        } 
    }    
}

class Player {
    var name: String
    var score: Int = 0

    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }

    func scorePoints(points: Int = 1) {
        self.score += points
        print("\(name) scored!")
    }
}

class Game {
    var player1: Player = Player(name: "Player 1", score: 0)
    var player2: Player = Player(name: "Player 2", score: 0)
    var state: gameState = .ongoing

    init() {
    }

    func play() {
        var randomNumber = Int.random(in: 1...2)
        if randomNumber == 1 {
            player1.scorePoints()
        } else  {
            player2.scorePoints()
        } 

        guard player1.score >= 4 || player2.score >= 4 else {
            return
        }

        if abs(player1.score - player2.score) >= 2 {
            if player1.score > player2.score {
                state = .finished(winner: player1)
                print("Game finished. Winner: \(player1.name) with score: \(player1.score) - \(player2.score)")                
            } else {
                state = .finished(winner: player2)
                print("Game finished. Winner: \(player2.name) with score: \(player1.score) - \(player2.score)")             
            }             
        }
        
    }

    func addPoint(to player: Player) throws{
        switch state {
            case .ongoing:
                player.scorePoints()
            case .finished(let winner):
                print("Game already finished. Winner: \(winner.name) with score: \(winner.score)")
                throw gameError.gameAlreadyFinished    
        }

    }

    func getWinner() throws -> Player {
        switch state {
        case .ongoing:
            throw gameError.gameNotFinished
        case .finished(let winner):
            return winner
        }       
    }

    func isOngoing() -> Bool {
        switch state {
        case .ongoing:
            return true
        case .finished(_):
            return false       
        }   
    }
    
}

enum gameState{
    case ongoing
    case finished(winner: Player)
}

enum gameError: Error {
    case gameAlreadyFinished
    case gameNotFinished
}
