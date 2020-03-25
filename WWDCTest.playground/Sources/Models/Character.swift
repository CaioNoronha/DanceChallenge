import SpriteKit
import UIKit

public class Character : SKSpriteNode {
    
    //Attributes
    var level: Int
    var hp: Int
    fileprivate var attack1 : Action
    fileprivate var attack2 : Action
    fileprivate var shield : Action
    
    //Constructor
    init(textureName: String) {
        level = 1
        hp = 10 * level
        attack1 = Action(points: 3, waitingTimer: 0)
        attack2 = Action(points: 6, waitingTimer: 3)
        shield = Action(points: 3, waitingTimer: 2)
        
        let texture = SKTexture(imageNamed: textureName)
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Methods
    public func attack(_ type: Int) -> Int {
        
        if type == 2 {
            if attack2.isAvaiable {
                print("Damage 2:", attack2.points)
                attack2.isAvaiable = false
                return attack2.points
            } else {
                print("Damage 2: Charging")
                return 0
            }
        }
        print("Damage 1:", attack1.points)
        return attack1.points
    }
    
    public func defend(damage: Int) {
        if shield.isAvaiable {
            if damage > shield.points {
                hp -= damage - shield.points
            }
            shield.isAvaiable = false
        }
    }
    
    public func hited(damage: Int) {
        if damage >= hp {
            die()
        } else {
            hp -= damage
        }
    }
    
    private func die() {
        self.alpha =  0.0
    }
    
    
    public func rechargeAbilitys() {
        attack2.recharge()
        shield.recharge()
    }
    
    public func levelUp() {
        attack1.points = 3/10 * hp
        attack2.points = 5/10 * hp
        shield.points = 3/10 * hp
    }
}

fileprivate class Action {
    
    //Attributes
    var points: Int
    var waitingTimer: Int
    var timer: Int
    var isAvaiable: Bool
        
    //Constructor
    init(points: Int, waitingTimer: Int) {
        self.points = points
        self.waitingTimer = waitingTimer
        self.timer = 0
        self.isAvaiable = true
    }
    
    //Methods
    public func recharge() {
        if !isAvaiable {
            timer += 1
            if timer == waitingTimer {
                timer = 0
                isAvaiable = true
            }
        }
    }
}

