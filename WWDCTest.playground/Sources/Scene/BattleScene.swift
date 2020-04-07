import SpriteKit

public class BattleScene: SKScene, BaseScene {
    
    //Sprites
    var simpleAttackButton: SKSpriteNode
    var shieldButton: SKSpriteNode
    var especialAttackButton: SKSpriteNode
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
    weak var sceneManager: SceneTransitionDelegate?
    
    //Constructor
    public init(size: CGSize, level: Int) {
        simpleAttackButton = SKSpriteNode(imageNamed: "Battle/Button/Battle_Button_S.Attack")
        shieldButton = SKSpriteNode(imageNamed: "Battle/Button/Battle_Button_Defend")
        especialAttackButton = SKSpriteNode(imageNamed: "Battle/Button/Battle_Button_E.Attack")
        self.background = SKSpriteNode(imageNamed: "Battle/Background/Battle_Background_\(level)")
        battle = Battle(level: level)
        self.level = level

        super.init(size: size)
        setUpScene()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Methods
    func setUpScene() {
        simpleAttackButton.name = "Simple Button"
        simpleAttackButton.position = CGPoint(x: width/1.84, y: height/4)
        self.addChild(simpleAttackButton)
        
        shieldButton.name = "Shield Button"
        shieldButton.position = CGPoint(x: width/1.28, y: height/4)
        self.addChild(shieldButton)
        
        especialAttackButton.name = "Especial Button"
        especialAttackButton.position = CGPoint(x: width/1.5, y: height/6.5)
        self.addChild(especialAttackButton)
        
        //Background
        background.zPosition = -1
        background.position = CGPoint(x: width/2, y: height/2)
        self.addChild(background)
        
        battle.observer = self
        
        //Enemy
        battle.enemy.node.position = CGPoint(x: width/1.48, y: height/1.8)
        self.addChild(battle.enemy.node)
                
        battle.enemy.hpNode.position = CGPoint(x: width/1.62, y: height/2.8)
        self.addChild(battle.enemy.hpNode)

        battle.enemy.characterLabel.position = CGPoint(x: width/1.48, y: height/1.4)
        self.addChild(battle.enemy.characterLabel)
        
        //Player
        battle.player.node.position = CGPoint(x: width/3.5, y: height/2.5)
        self.addChild(battle.player.node)
        
        battle.player.hpNode.position = CGPoint(x: width/4.5, y: height/30)
        battle.player.hpNode.setScale(1.5)
        self.addChild(battle.player.hpNode)
        
        battle.player.characterLabel.position = CGPoint(x: width/3.5, y: height/1.8)
        self.addChild(battle.player.characterLabel)
    }
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
            
        case "Simple Button":
            battle.playerAct(.attack1)
            
        case "Shield Button":
            battle.playerAct(.defend)

        case "Especial Button":
            battle.playerAct(.attack2)
           
        default:
            print("Nothing detected!")
        }
    }
}

