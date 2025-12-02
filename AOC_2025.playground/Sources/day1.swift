import Foundation

public func day1() {
    let fileUrl = Bundle.main.url(forResource: "day_1_source", withExtension: nil)!
    let data = try! String(contentsOf: fileUrl, encoding: .utf8)

    let lines = data.split(separator: "\n")

    var current = 50
    var numberOfZeros = 0
    lines.forEach { line in
        
        var theLine = line
        let direction = theLine.removeFirst()
        let number = Int(theLine)!
        
        if direction == "R" {
            current += number
            
            while current > 99 {
                numberOfZeros += 1
                current -= 100
            }
            
        } else {
            let before = current
            current -= number
            
            if current == 0 {
                numberOfZeros += 1
            } else {
                
                if current < 0 {
                    while current < 0 {
                        numberOfZeros += 1
                        current += 100
                    }
                    
                    if before == 0 {
                        numberOfZeros -= 1
                    }
                }
                
                if current == 0 {
                    numberOfZeros += 1
                }
            }
        }

    }

    print(numberOfZeros)
}
