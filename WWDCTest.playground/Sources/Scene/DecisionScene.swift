import SpriteKit

public class DecisionScene: SKScene, BaseScene {
    
    //Nodes
    private var leftButton: SKSpriteNode
    private var rightButton: SKSpriteNode
    private var background: SKSpriteNode
    private var enemyNode: SKSpriteNode
    private var enemyMessage = SKLabelNode()

    
    //Attributes
    var level: Int
    weak var sceneManager: SceneTransitionDelegate?
    
    //Constructor
    public init(size: CGSize, level: Int) {
        self.level = level
        
        enemyNode = SKSpriteNode(imageNamed: "enemy\(level)")
        leftButton = SKSpriteNode(imageNamed: "Button1")
        rightButton = SKSpriteNode(imageNamed: "Button1")
        background = SKSpriteNode(imageNamed: "Background")
        super.init(size: size)
        setUpScene()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Methods
    
    func setUpScene() {
        
        //LeftButton
        leftButton.name = "Left Button"
        leftButton.position = CGPoint(x: self.size.width/4, y: self.size.height/2)
        leftButton.setScale(1.5)
        self.addChild(leftButton)
        
        //RightButton
        rightButton.name = "Right Button"
        rightButton.position = CGPoint(x: self.size.width/1.5, y: self.size.height/2)
        rightButton.setScale(1.5)
        self.addChild(rightButton)
        
        //BackGround
        background.zPosition = -1
        rightButton.setScale(1.5)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        //EnemyMessage
        enemyMessage.text = setEnemyMessage()
        enemyMessage.fontSize = 12
        enemyMessage.fontName = "Pixel Tactical"
        enemyMessage.position = CGPoint(x: self.size.width/2, y: self.size.height/1.2)
        enemyMessage.numberOfLines = 2
        self.addChild(enemyMessage)
        
        
            
    }
    
    private func setEnemyMessage() -> String {
        switch level {
        case 1:
            return "You are nothing, you will never get in there! \n if i would you, i would go on left way to try be like me!"
        case 2:
            return "You are stronger, but you are no better than me! \n If I were you, I would practice every day \n to try to be a little like myself and be able to see \n myself as the best dancer! Turn right to practice and see me win!"
        case 3:
            return "You're amazing! It can be much better, \n keep practicing and you will be \n the best dancer, I believe in you! If you need help, \n give me a call! Turn left to go to the castle!"
        default:
            return "You are nothing, you will never get in there! \n if i would you, i would go on left way to try be like me!"
        }
    }
    
    func changeScene() {
        
        switch level {
        case 1:
            sceneManager?.transitionToScene(.battleScene2)
        case 2:
            sceneManager?.transitionToScene(.battleScene3)
        case 3:
            sceneManager?.transitionToScene(.endScene)
        default:
            print("Error")
            sceneManager?.transitionToScene(.initialScene)
        }
    }
}

extension DecisionScene {
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        //Take the first touch
        let touch = touches.first
        //Touch in the screen position
        let positionInScene = touch?.location(in: self)
        // The knot is in that position now
        let touchedNode = self.atPoint(positionInScene!)
        
//        switch touchedNode.name {
//        case "Left Button":
//        case "Right Button":
//        default:
//        }
        
        changeScene()
    }
}

