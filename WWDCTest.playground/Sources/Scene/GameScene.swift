import SpriteKit

public class GameScene: SKScene, BaseScene {
    
    //Sprites
    var player: Character
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
    var playLabel: SKLabelNode
    var sceneManager: SceneTransitionDelegate?
    
    //Constructor
    public override init(size: CGSize) {
        playLabel = SKLabelNode(text: "Oin, to no jogo")
        player = Character(textureName: "Personagem")
        
        attackButton1 = SKSpriteNode(imageNamed: "AttackButton")
        attackButton2 = SKSpriteNode(imageNamed: "AttackButton")
        defendButton = SKSpriteNode(imageNamed: "DefendButton")
        
        background = SKSpriteNode(imageNamed: "Lente Negra")
        super.init(size: size)
        setUpScene()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Methods
    
    func setUpScene() {
        playLabel.position = CGPoint(x: width/2, y: height/3)
        playLabel.fontName = "Pixel Tactical"
        playLabel.fontSize = 18
        self.addChild(playLabel)
        
        attackButton1.name = "Attack Button 1"
        attackButton1.position = CGPoint(x: width/2, y: height/4)
        attackButton1.setScale(1.5)
        self.addChild(attackButton1)
        
        attackButton2.name = "Attack Button 2"
        attackButton2.position = CGPoint(x: width/1.5, y: height/4)
        attackButton2.setScale(1.5)
        self.addChild(attackButton2)
        
        player.position = CGPoint(x: width/4, y: height/4)
        self.addChild(player)
        
        //self.backgroundColor = .blue
        background.zPosition = -1
        background.position = CGPoint(x: width/2, y: height/2)
        //self.addChild(background)
        
        animate()
        
    }
    
    func animate() {
        let actionArray = [
            SKAction.fadeAlpha(to: 0.4, duration: 0.8),
            SKAction.fadeAlpha(to: 1, duration: 0.8)]
        
        playLabel.run(SKAction.repeatForever(SKAction.sequence(actionArray)))
    }
    
    func startGame() {
        sceneManager?.transitionToScene(.initialScene)
    }
}

extension GameScene {
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        //Take the first touch
        let touch = touches.first
        //Touch in the screen position
        let positionInScene = touch?.location(in: self)
        // The knot is in that position now
        let touchedNode = self.atPoint(positionInScene!)
        
        if touchedNode.name == "Attack Button 1" {
            print("Atacou com o ataque 1!")
        }
        
        if touchedNode.name == "Attack Button 2" {
            print("Atacou com o ataque 2!")
        }
        
        startGame()
    }
}

