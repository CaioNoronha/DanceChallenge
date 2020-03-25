import SpriteKit

protocol BaseScene {
    var sceneManager: SceneTransitionDelegate? { get set }
//    var width : CGFloat { get set }
//    var height: CGFloat { get set }
}

//extension BaseScene {
//    var width: CGFloat {
//        return self.size.width
//    }
//    var height: CGFloat {
//        return self.size.height
//    }
//}


public enum SceneIdentifier {
    case initialScene, gameScene, pauseScene, endScene
}

protocol SceneTransitionDelegate {
    func transitionToScene(_ indentifier: SceneIdentifier)
}

public class SceneManager : SceneTransitionDelegate {
    
    //Attributes
    public var sceneView: SKView
    var scenes: [SceneIdentifier: SKScene] = [:]
    var currentScene: SKScene?
    
    //Constructor
    public init(view: SKView) {
        sceneView = view
        addFonts()
    }
    
    //Methods
    private func addFonts() {
        let fontURL = Bundle.main.url(forResource: "Pixel Tactical", withExtension: "otf")
        CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
    }
    
    public func transitionToScene(_ indentifier: SceneIdentifier) {
        if let scene = scenes[indentifier] {
            self.currentScene = scene
        } else {
            let scene = createScene(indentifier)
            scenes[indentifier] = scene
            self.currentScene = scene
        }
        sceneView.presentScene(currentScene)
    }
    
    fileprivate func createScene(_ indentifier: SceneIdentifier) -> SKScene {
        let viewSize = sceneView.frame.size
        
        switch indentifier {
            
        case .initialScene:
            let initial = InitialScene(size: viewSize)
            initial.sceneManager = self
            return initial
            
        case .gameScene:
            let gameScene = GameScene(size: viewSize)
            gameScene.sceneManager = self
            return gameScene
            
        case .pauseScene:
            let pauseScene = GameScene(size: viewSize)
            pauseScene.sceneManager = self
            return pauseScene
            
        case .endScene:
            let endScene = GameScene(size: viewSize)
            endScene.sceneManager = self
            return endScene
        }
    }
}
