import PlaygroundSupport
import SpriteKit


var sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 667, height: 375))
public var sceneManager = SceneManager(view: sceneView)
sceneManager.transitionToScene(.initialScene)

PlaygroundPage.current.liveView = sceneManager.sceneView
