import SpriteKit

public class Character {
    
    private enum CharacterAnimation {
    case simpleAttack, especialAttack, defend
    }
    
    //Nodes
    var node = SKSpriteNode()
    var hpNode = SKSpriteNode(imageNamed: "Battle/HP")
    var simpleAttackAnimate = [SKTexture]()
    var especialAttackAnimate = [SKTexture]()
    var shieldAnimate = [SKTexture]()
    var characterLabel = SKLabelNode()
    
    //Attributes
    private var name: String
    private var hp: Int
    private var level: Int
    private var especialAttack = CustomAction(2)
    private var shield = CustomAction(3)
    var isAlive = true
    
    
    private var hpWidthMax: CGFloat
    
    private var hpWidth: CGFloat {
        let hpPorcent = CGFloat(hp/(15 * level))
        return hpPorcent * hpWidthMax
    }

    private var simpleDamage: Int {
        return level * 2
    }
    private var especialDamage: Int {
        return level * 5
    }
    
    init(name: String, level: Int) {
        self.name = name
        self.level = level
        self.hp = 15 * level
        self.hpWidthMax = hpNode.size.width
        
        setUpNodes()
    }
    
    private func setUpNodes() {
        
        if name == "Caio" {
            node = SKSpriteNode(imageNamed: "Battle/Enemy/Player")
            for i in 1...5 {
                simpleAttackAnimate.append(SKTexture(imageNamed: "Battle/Player/\(level)/S.Attack/Battle_\(name)_\(level)_S.Attack_\(i)"))
                
                especialAttackAnimate.append(SKTexture(imageNamed: "Battle/Player/\(level)/E.Attack/Battle_\(name)_\(level)_E.Attack_\(i)"))
                
                shieldAnimate.append(SKTexture(imageNamed: "Battle/Player/\(level)/Heal/Battle_\(name)_\(level)_Heal_\(i)"))
                
            }
        } else {
            node = SKSpriteNode(imageNamed: "Battle/Enemy/\(level)/Enemy_\(level)")
            for i in 1...5 {
                simpleAttackAnimate.append(SKTexture(imageNamed: "Battle/Enemy/\(level)/S.Attack/Battle_Enemy_\(level)_S.Attack_\(i)"))
                
                especialAttackAnimate.append(SKTexture(imageNamed: "Battle/Enemy/\(level)/E.Attack/Battle_Enemy_\(level)_E.Attack_\(i)"))
                
                shieldAnimate.append(SKTexture(imageNamed: "Battle/Enemy/\(level)/Defend/Battle_Enemy_\(level)_Defend_\(i)"))
                
            }
            simpleAttackAnimate.append(SKTexture(imageNamed: "Battle/Enemy/\(level)/Enemy_\(level)"))
            especialAttackAnimate.append(SKTexture(imageNamed: "Battle/Enemy/\(level)/Enemy_\(level)"))
            shieldAnimate.append(SKTexture(imageNamed: "Battle/Enemy/\(level)/Enemy_\(level)"))
        }
    }
    
    
    public func attack(_ type: Int) -> Int {
        if type == 1 {
            characterLabel.text = "\(name) used Simple Attack!"
            animate(.simpleAttack)
            return simpleDamage
        }
        
        if type == 2, especialAttack.use() {
            characterLabel.text = "\(name) used Especial Attack!"
            animate(.especialAttack)
            return especialDamage
        }
        characterLabel.text = "\(name) is reloading!"
        return 0
    }
    
    public func defend() -> Int {
        if shield.use() {
            characterLabel.text = "\(name) used Shield!"
            animate(.defend)
            return 1
        }
        characterLabel.text = "\(name) is reloading!"
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
        
        hpNode.size.width = hpWidth
    }
    
    private func animate(_ animation: CharacterAnimation) {
        
        switch animation {
        case .simpleAttack:
            node.run(SKAction.animate(with: simpleAttackAnimate, timePerFrame: 0.3))
        case .especialAttack:
            node.run(SKAction.animate(with: especialAttackAnimate, timePerFrame: 0.3))
        case .defend:
            node.run(SKAction.animate(with: shieldAnimate, timePerFrame: 0.3))
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
        self.onUsing = false
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



