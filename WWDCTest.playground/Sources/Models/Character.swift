import SpriteKit

public class Character {
    
    var node: SKSpriteNode
    var hp: Int
    var lvl: Int
    
    init(name: String) {
        node = SKSpriteNode(imageNamed: name)
        node.name = name
        lvl = 1
        hp = 10 * lvl
    }
    
    func attack(_ type: Int) -> Int {
        //change texture
        return type + (type-1)
    }
    
    func hited(damage: Int) -> Bool {
        if damage >= hp {
            //Animate
            return true
        }
        //Animate
        return false
    }
}

/*
 Animation:
 node.texture = SKTexture(imageNamed: "")
 SKAction.fadeAlpha(to: 0.0, duration: 0.8)
 
 */
