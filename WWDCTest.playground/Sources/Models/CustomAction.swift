public struct CustomAction {
    
    private var timeToLoad: Int
    private var load: Int
    var onUsing: Bool
    
    init(_ timeToLoad: Int) {
        self.timeToLoad = timeToLoad
        self.load = timeToLoad
        self.onUsing = false
    }
    
    public mutating func use() -> Bool {
        if !onUsing {
            load = 0
            onUsing = true
            return true
        }
        return false
    }
    
    public mutating func reload() {
        if load != timeToLoad {
            load += 1
            return
        }
        onUsing = false
    }
}



