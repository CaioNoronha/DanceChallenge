import SpriteKit

public class InitialScene: SKScene, BaseScene {
    
    //Attributes
    weak var sceneManager: SceneTransitionDelegate?
    
    //Nodes
    var playLabel: SKLabelNode
    var background: SKSpriteNode
    var spotlight1: SKSpriteNode
    var spotlight2: SKSpriteNode
    
    //Constructor
    public override init(size: CGSize) {
        playLabel = SKLabelNode(text: "Press anywhere to start")
        background = SKSpriteNode(imageNamed: "InitialScene/InitialBackground")
        spotlight1 = SKSpriteNode(imageNamed: "InitialScene/Spotlight 1")
        spotlight2 = SKSpriteNode(imageNamed: "InitialScene/Spotlight 2")
        super.init(size: size)
        setUpScene()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Methods
    
    func setUpScene() {
        
        //BackGround
        background.zPosition = -1
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        //Spotlight 1
        spotlight1.position = CGPoint(x:self.size.width/1.65 ,y: self.size.height/1.3)
        self.addChild(spotlight1)
        
        //Spotlight 2
        spotlight2.position = CGPoint(x:self.size.width/1.27, y: self.size.height/1.2)
        self.addChild(spotlight2)
        
        //PlayerLabel
        playLabel.position = CGPoint(x: self.size.width/1.3, y: self.size.height/9)
        playLabel.fontName = "Nunito-Regular"
        playLabel.fontSize = 20
        self.addChild(playLabel)
        
        animate()
        
    }
    
    func animate() {
        let x = SKAction.rotate(toAngle: CGFloat(0.1), duration: 1)
        
        spotlight1.run(x)
        
        let actionArray = [
            SKAction.fadeAlpha(to: 0.4, duration: 0.8),
            SKAction.fadeAlpha(to: 1, duration: 0.8)]
        
        playLabel.run(SKAction.repeatForever(SKAction.sequence(actionArray)))
    }
    
    func startGame() {
        sceneManager?.transitionToScene(.battleScene1)
    }
}

extension InitialScene {
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        print("Initial ---------- Going to BattleScene ----------")
        startGame()
    }
}

