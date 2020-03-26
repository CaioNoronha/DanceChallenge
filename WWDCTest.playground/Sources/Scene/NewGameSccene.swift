import SpriteKit

public class GameScene1: SKScene, BaseScene {

    //Attributes
    var width: CGFloat {
        return self.size.width
    }
    var height: CGFloat {
        return self.size.height
    }
    var sceneManager: SceneTransitionDelegate?
    
    //Sprites
    //var attackButton1
    
    
    private func setUp() {
        
    }
    
    
}

extension GameScene1 {
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        //Take the first touch
        let touch = touches.first
        //Touch in the screen position
        let positionInScene = touch?.location(in: self)
        // The knot is in that position now
        let touchedNode = self.atPoint(positionInScene!)
    }
}

