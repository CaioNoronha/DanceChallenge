public enum CharacterAction {
    case attack1, attack2, defend
}




public class Battle {
    
    private var player: Character
    private var enemy: Character
    public var isFighting: Bool
    
    
    init(player: Character, enemy: Character) {
        self.player = player
        self.enemy = enemy
        self.isFighting = true
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
            let random = Int.random(in: 1...3)
            repeat {
                //Randomize the enemy action
                switch random {
                case 1:
                    ability = enemy.attack(random)
                case 2:
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
                    isFighting = false
                    //Player lose the game
                    print("Enemy wins")
                }
            }
        } else {
            //Player is the winner
            isFighting = false
            print("Player wins")
        }
    }
}

