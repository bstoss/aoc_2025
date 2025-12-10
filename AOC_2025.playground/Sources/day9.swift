import Foundation

public func day9_1() {
    
    let fileUrl = Bundle.main.url(forResource: "day_9_source", withExtension: nil)!
    let input = try! String(contentsOf: fileUrl, encoding: .utf8)
    
    var coords: [(x: Int, y: Int)] = input.split(separator: "\n").map { line in
        let coord = line.split(separator: ",").map {
            Int($0)!
        }
        
        return (x: coord[0], y: coord[1])
    }
    
    var highestArea = 0
    for i in 0..<coords.count {
        
        for j in (i+1)..<coords.count {
            let diffx = abs(coords[i].x - coords[j].x)
            let diffy = abs(coords[i].y - coords[j].y)
            
            let area = (diffx+1) * (diffy+1)
            if area > highestArea {
                highestArea = area
            }
        }
    }
    
    print(highestArea)
}
