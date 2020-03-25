import SpriteKit

public class InitialScene: SKScene, BaseScene {
    
    //Attributes
    var playLabel: SKLabelNode
    var background: SKSpriteNode
    var sceneManager: SceneTransitionDelegate?
    
    //Constructor
    public override init(size: CGSize) {
        playLabel = SKLabelNode(text: "Press anywhere to start")
        background = SKSpriteNode(imageNamed: "Lente Negra")
        super.init(size: size)
        setUpScene()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Methods
    
    func setUpScene() {
        //PlayerLabel
        playLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/3)
        playLabel.fontName = "Pixel Tactical"
        playLabel.fontSize = 18
        self.addChild(playLabel)
        
        //BackGround
        background.zPosition = -1
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        animate()
        
    }
    
    func animate() {
        let actionArray = [
            SKAction.fadeAlpha(to: 0.4, duration: 0.8),
            SKAction.fadeAlpha(to: 1, duration: 0.8)]
        
        playLabel.run(SKAction.repeatForever(SKAction.sequence(actionArray)))
    }
    
    func startGame() {
        sceneManager?.transitionToScene(.gameScene)
    }
}

extension InitialScene {
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        startGame()
        print("estou aqui")
    }
}

