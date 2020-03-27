import SpriteKit




public class Character {
    
    //Attributes
    var node: SKSpriteNode
    var isAlive: Bool
    private var hp: Int
    private var level: Int
    private var especialAttack: CustomAction
    private var shield: CustomAction
    private var simpleDamage: Int {
        return level * 2
    }
    private var especialDamage: Int {
        return level * 5
    }
    
    init(name: String, level: Int) {
        node = SKSpriteNode(imageNamed: "name")
        node.name = name
        self.level = level
        self.hp = 15 * level
        self.especialAttack = CustomAction(3)
        self.shield = CustomAction(2)
        self.isAlive = true
    }
    
    
    public func attack(_ type: Int) -> Int {
        if type == 1 {
            print("\(node.name) used Simple Attack!")
            return simpleDamage
        }
        
        if especialAttack.use() {
            print("\(node.name) used Especial Attack!")
            return especialDamage
        }
        print("\(node.name) is Reloading!")
        return 0
    }
    
    public func defend() -> Int {
        if shield.use() {
            print("\(node.name) used Shield!")
            return 1
        }
        print("\(node.name) is Reloading!")
        return 0
    }
    
    public func hit(damage: Int) {
        if shield.onUsing {
            hp -= damage/level*2
        } else {
            hp -= damage
        }
        if hp <= 0 {
            isAlive = false
        }
    }
    
    public func reloadAbilitys() {
        especialAttack.reload()
        shield.reload()
    }
    
    public func levelUp() {
        level += 1
        hp = 15 * level
    }
    
    
}

public struct CustomAction {
    
    private var timeToLoad: Int
    private var load: Int
    var onUsing: Bool
    
    init(_ timeToLoad: Int) {
        self.timeToLoad = timeToLoad
        self.load = timeToLoad
        self.onUsing = true
    }
    
    public mutating func use() -> Bool {
        if !onUsing {
            load = 0
            onUsing = true
            return true
        }
        return false
    }
    
    public mutating func reload() {
        if load != timeToLoad {
            load += 1
            return
        }
        onUsing = false
    }
}



