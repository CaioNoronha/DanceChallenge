import SpriteKit
import UIKit

public class DecisionScene: SKScene, BaseScene {
    
    //Nodes
    private var leftButton: SKSpriteNode
    private var rightButton: SKSpriteNode
    private var background: SKSpriteNode
    private var enemy: SKSpriteNode
    private var message = SKLabelNode()
    private var ballon: SKSpriteNode

    
    //Attributes
    var level: Int
    weak var sceneManager: SceneTransitionDelegate?
    
    //Constructor
    public init(size: CGSize, level: Int) {
        self.level = level
        
        enemy = SKSpriteNode(imageNamed: "Battle/Enemy/\(level)/Enemy_\(level)")
        leftButton = SKSpriteNode(imageNamed: "Decision/Decision_LeftButton")
        rightButton = SKSpriteNode(imageNamed: "Decision/Decision_RightButton")
        background = SKSpriteNode(imageNamed: "Decision/\(level)/Decision_\(level)_Background")
        ballon = SKSpriteNode(imageNamed: "Decision/Decision_Ballon")
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
        leftButton.position = CGPoint(x: self.size.width/4, y: self.size.height/4)
        self.addChild(leftButton)
        
        //RightButton
        rightButton.name = "Right Button"
        rightButton.position = CGPoint(x: self.size.width/1.5, y: self.size.height/4)
        self.addChild(rightButton)
        
        //Enemy
        enemy.position = CGPoint(x: self.size.width/2.2, y: self.size.height/2.5)
        self.addChild(enemy)
        
        //BackGround
        background.zPosition = -2
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        //Ballon
        ballon.position = CGPoint(x: self.size.width/2, y: self.size.height/1.3)
        ballon.zPosition = -1
        self.addChild(ballon)
        
        //Message
        message.text = setEnemyMessage()
        message.fontSize = 16
        message.fontName = "Nunito Regular"
        message.fontColor = UIColor.black
        message.position = CGPoint(x: self.size.width/2, y: self.size.height/1.3)
        message.numberOfLines = 2
        self.addChild(message)
        
//        let music = SKAction.playSoundFileNamed("Music.mp3", waitForCompletion: false)
//        self.run(music)
    }
    
    private func setEnemyMessage() -> String {
        switch level {
        case 1:
            return "You are nothing, you will never get in there! \n if i would you, i would go on left way to try be like me!"
        case 2:
            return "You are stronger, but you are no better than me! \n If I were you, I would practice every day to try to\n be a little like me! Turn right to practice and see me win!"
        case 3:
            return "You're amazing! keep practicing and you will be \n the best dancer, I believe in you! If you need help, \n give me a call! Turn left to go to the castle!"
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
        
        switch touchedNode.name {
        case "Left Button":
            print(" Left")
            changeScene()

        case "Right Button":
            print(" Right")
            changeScene()

        default:
            print("Nothing detected!")
        }
        
    }
}

