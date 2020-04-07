import AVFoundation

public class Music {
    static let shared = Music()
    var audioPlayer: AVAudioPlayer?
    
    private init() {}

    //Initia lMusic
    public func playMusic() {
        do {
            if let song = Bundle.main.path(forResource: "Music", ofType: "mp3") {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: song))
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            }
        } catch {
            print("Initial Music Error")
        }
    }
    
    public func stopMusic() {
        audioPlayer?.stop()
    }
    
    public func pauseMusic() {
        audioPlayer?.pause()
    }
    
    public func resumeMusic() {
        audioPlayer?.play()
    }
}

