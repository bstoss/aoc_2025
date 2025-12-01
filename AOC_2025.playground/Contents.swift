import Foundation

let fileUrl = Bundle.main.url(forResource: "day_1_source", withExtension: nil)!
let data = try! String(contentsOf: fileUrl, encoding: .utf8)

let lines = data.split(separator: "\n")

var current = 50
var numberOfZeros = 0
lines.forEach { line in
    
    let currentBefore = current
    var addedZero = false
    
    var theLine = line
    let direction = theLine.removeFirst()
    let number = Int(theLine)!
    print("\(direction)\(theLine) - \(current) - \(numberOfZeros)")
    
    if direction == "R" {
        current += number
        
        while current > 99 {
            numberOfZeros += 1
            current -= 100
        }
        
    } else {
        
        // current ist zwischen 0 und 99
        
        current -= number
        
        // kann auf 0 fallen
        if current == 0 {
            numberOfZeros += 1
        } else {
            
            // kann kleiner als 0 werden.
            while current < 0 {
                numberOfZeros += 1
                current += 100
                addedZero = true
                print(current)
            }
            // L615 - 15 - 166
            if currentBefore == 0 && addedZero {
                print("\(currentBefore) - \(numberOfZeros)")
                numberOfZeros -= 1
            }
            
            if current == 0 {
                numberOfZeros += 1
            }
        }
    }
    
    
    print("\(direction)\(theLine) - \(current) - \(numberOfZeros)")

}

print(numberOfZeros)
