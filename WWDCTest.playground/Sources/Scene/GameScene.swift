import SpriteKit

public class GameScene: SKScene, BaseScene {
    
    //Sprites
    var player: Character
    var enemy = [Character(textureName: "Enemy1")]
    var currentEnemy: Character?
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
        
        enemy[0].position = CGPoint(x: width/8, y: height/1.5)
        currentEnemy = enemy[0]
        self.addChild(enemy[0])
        
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
        
        switch touchedNode.name {
        case "Attack Button 1":
            currentEnemy!.hited(damage: self.player.attack(1))
            print("\nTurn Passed\n")
            //Passar o turno
            player.rechargeAbilitys()
            //Vez do Inimigo
            
        case "Attack Button 2":
            let playerDamage = self.player.attack(2)
            if playerDamage > 0 {
                currentEnemy!.hited(damage: playerDamage)
                print("\nTurn Passed\n")
                player.rechargeAbilitys()
            } else {
                
            }
            //Passar o turno
            
        case "Defend Button":
            self.player.defend(damage: 5)
            print("\nTurn Passed\n")
            //Passar o turno
            player.rechargeAbilitys()

        default:
            print("Nothing detected!")
            startGame()
        }
    }
}

