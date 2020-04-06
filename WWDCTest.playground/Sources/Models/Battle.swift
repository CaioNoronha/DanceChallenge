public enum CharacterAction {
    case attack1, attack2, defend
}

public class Battle {
    
    var player: Character
    var enemy: Character
    var isFighting = true {
        didSet {
            observer?.finishBattle()
        }
    }
    
    public weak var observer: Observer?
    
    
    init(level: Int) {
        self.player = Character(name: "Player", level: level)
        
        switch level {
        case 1:
            self.enemy = Character(name: "Josh", level: level)
        case 2:
            self.enemy = Character(name: "Bob", level: level)
        case 3:
            self.enemy = Character(name: "Fernando", level: level)
        default:
            self.enemy = Character(name: "Josh", level: level)
        }
    }
    
    
    public func playerAct(_ action: CharacterAction) {
        switch action {
        case .attack1:
            enemy.hit(damage: player.attack(1))
            //Mudar asset
            turnPassed()
            
        case .attack2:
            let damage = player.attack(2)
            
            if damage != 0 {
                enemy.hit(damage: damage)
                //Mudar asset
                turnPassed()
            } else {
                print("Reloading")
            }
            
        case .defend:
            if player.defend() != 0 {
                //Mudar asset
                turnPassed()
            } else {
                print("Reloading")
            }
        }        
    }
    
    private func turnPassed() {
        
        //Checks if the enemy is alive
        if enemy.isAlive {
            player.reloadAbilitys()
            enemy.reloadAbilitys()
            
            var ability = 0
            var random : Int
            repeat {
                random = Int.random(in: 1...3)
                ability = 0
                //Randomize the enemy action
                switch random {
                case 1, 2:
                    ability = enemy.attack(random)
                case 3:
                    ability = enemy.defend()
                default:
                    ability = 0
                }
            } while ability == 0
            
            if random < 3 {
                player.hit(damage: ability)
                
                if !player.isAlive {
                    print("Enemy wins")
                    isFighting = false
                    //Player lose the game
                }
            }
        } else {
            //Player is the winner
            print("Player wins")
            isFighting = false

        }
    }
}

