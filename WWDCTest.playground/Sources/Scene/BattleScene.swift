import SpriteKit

public protocol Observer: class {
    func finishBattle()
}

extension BattleScene: Observer {
    public func finishBattle() {
        
        switch level {
        case 1:
            sceneManager?.transitionToScene(.decisionScene1)
        case 2:
            sceneManager?.transitionToScene(.decisionScene2)
        case 3:
            sceneManager?.transitionToScene(.decisionScene3)
        default:
            sceneManager?.transitionToScene(.initialScene)
        }
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
    var level: Int
    var battle: Battle
    var sceneManager: SceneTransitionDelegate?
    
    //Constructor
    public init(size: CGSize, level: Int) {
        attackButton1 = SKSpriteNode(imageNamed: "Button1")
        attackButton2 = SKSpriteNode(imageNamed: "Button1")
        defendButton = SKSpriteNode(imageNamed: "Button2")
        self.background = SKSpriteNode(imageNamed: "")
        battle = Battle(player: Character(name: "Player", level: level), enemy: Character(name: "Enemy", level: level))
        self.level = level

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
        
        battle.observer = self
        
        battle.enemy.node.position = CGPoint(x: width/1.1, y: height/1.5)
        self.addChild(battle.enemy.node)
        
        battle.player.node.position = CGPoint(x: width/4, y: height/4)
        self.addChild(battle.player.node)
    }
}

extension BattleScene {
    
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

