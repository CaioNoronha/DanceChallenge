import SpriteKit

public protocol Observer: class {
    func finishBattle()
}

extension BattleScene: Observer {
    public func finishBattle() {
        sceneManager?.transitionToScene(.initialScene)
    }
}

public class BattleScene: SKScene, BaseScene {
    
    //Sprites
    var attackButton1: SKSpriteNode
    var attackButton2: SKSpriteNode
    var defendButton: SKSpriteNode
    var background: SKSpriteNode

    
    //Attributes
    var width: CGFloat {
        return self.size.width
    }
    var height: CGFloat {
        return self.size.height
    }
    var battle: Battle
    var level: Int
    var sceneManager: SceneTransitionDelegate?
    
    //Constructor
    public override init(size: CGSize) {
        attackButton1 = SKSpriteNode(imageNamed: "AttackButton")
        attackButton2 = SKSpriteNode(imageNamed: "AttackButton")
        defendButton = SKSpriteNode(imageNamed: "DefendButton")
        self.level = 0
        print(self.level)
        self.background = SKSpriteNode(imageNamed: "")
        battle = Battle(player: Character(name: "Player", level: level), enemy: Character(name: "Enemy\(level)", level: level))

        super.init(size: size)
        setUpScene()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Methods
    func setUpScene() {
        attackButton1.name = "Attack Button 1"
        attackButton1.position = CGPoint(x: width/2.4, y: height/4)
        attackButton1.setScale(1.5)
        self.addChild(attackButton1)
        
        attackButton2.name = "Attack Button 2"
        attackButton2.position = CGPoint(x: width/1.71, y: height/4)
        attackButton2.setScale(1.5)
        self.addChild(attackButton2)
        
        defendButton.name = "Defend Button"
        defendButton.position = CGPoint(x: width/2, y: height/6.5)
        defendButton.setScale(1.5)
        self.addChild(defendButton)
        
        background.zPosition = -1
        background.position = CGPoint(x: width/2, y: height/2)
        self.addChild(background)
        
        setUpCharacters()
    }
    
    func levelUpBattle() {
        self.level += 1
        self.background.texture = SKTexture(imageNamed: "")

        battle = Battle(player: Character(name: "Player", level: level), enemy: Character(name: "Enemy\(level)", level: level))
        setUpCharacters()
    }
    
    private func setUpCharacters() {
        battle.observer = self
        
        battle.enemy.node.position = CGPoint(x: width/1.1, y: height/1.5)
        self.addChild(battle.enemy.node)
        
        battle.player.node.position = CGPoint(x: width/4, y: height/4)
        self.addChild(battle.player.node)
    }
}

extension BattleScene {
    
    public override func didMove(to view: SKView) {
        levelUpBattle()
    }
    
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        //Take the first touch
        let touch = touches.first
        //Touch in the screen position
        let positionInScene = touch?.location(in: self)
        // The knot is in that position now
        let touchedNode = self.atPoint(positionInScene!)
        
        switch touchedNode.name {
        case "Attack Button 1":
            battle.playerAct(.attack1)
        case "Attack Button 2":
            battle.playerAct(.attack2)
        case "Defend Button":
            battle.playerAct(.defend)
           
        default:
            print("Nothing detected!")
        }
    }
}

