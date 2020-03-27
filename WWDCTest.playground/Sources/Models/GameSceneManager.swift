import SpriteKit

public class GameSceneManager {
    
    //Delegate da GameScene(botões/background/assets)
    //Mudar Posição dos botões
    //Mudar Background
    //Mudar inimigo(position)
    //Mudar Battle(se tiver)
    
    var battle: Battle?
    var phaseLevel: Int
    //var gameSceneProtocol = GameSceneProtocol?
    
    init(phaseLevel: Int) {
        self.phaseLevel = phaseLevel
    }
    
   
    public func changeLevel() {
        initPhase()
    }
    
    public func initPhase() {
            //StartCutScene
            //StartBattle
            //Start Decision
       }
}
