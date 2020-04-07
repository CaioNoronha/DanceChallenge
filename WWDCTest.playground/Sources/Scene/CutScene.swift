import SpriteKit

public class CutScene: SKScene, BaseScene {
    
    
    //Attributes
    private var background = SKSpriteNode()
    private var scenes: [SKTexture] = []
    private var level: Int
    private var indexScene = 0
    private var labelStart = SKLabelNode(text: "Touch anywhere to continue")
    var sceneManager: SceneTransitionDelegate?

    
    //Constructor
    public init(size: CGSize, level: Int) {
        self.level = level
        super.init(size: size)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Methods
    private func setUp() {
        
        let fileName: String
        let animation = [
        SKAction.fadeAlpha(to: 0.4, duration: 0.8),
        SKAction.fadeAlpha(to: 1, duration: 0.8)]
        
        if level == 1 {
            fileName = "Introduction"
        } else {
            fileName = "EndScene"
        }
        
        self.background = SKSpriteNode(imageNamed: "CutScene/\(fileName)/CutScene_\(fileName)_1")
        
        for i in 2...5 {
            self.scenes.append(SKTexture(imageNamed: "CutScene/\(fileName)/CutScene_\(fileName)_\(i)"))
        }
        
        //Background
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        //LabelStart
        labelStart.position = CGPoint(x: self.size.width/1.3, y: self.size.height/9)
        labelStart.fontName = "Nunito Regular"
        labelStart.fontSize = 20
        self.addChild(labelStart)
        
        labelStart.run(SKAction.repeatForever(SKAction.sequence(animation)))
    }
    
    
    private func changeScene() {
        guard indexScene >= 3 else {
            background.texture = scenes[indexScene]
            indexScene += 1
            return
        }
        
        if level == 1 {
            sceneManager?.transitionToScene(.battleScene1)
        } else {
            sceneManager?.transitionToScene(.initialScene)
        }
        
    }
}

extension CutScene {
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        changeScene()
    }
    
    
}
