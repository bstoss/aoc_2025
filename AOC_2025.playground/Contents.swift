import Foundation

let fileUrl = Bundle.main.url(forResource: "day_6_source", withExtension: nil)!
let input = try! String(contentsOf: fileUrl, encoding: .utf8)

let lines = input.split(separator: "\n")

enum Operation: String {
    case add = "+"
    case mult = "*"
}

var numbers: [[Int]] = []
var operations: [Operation] = []


var noColumns: [[Int]] = []
var knownColumnIndex: [Int] = []
for line in lines.dropLast() {
    
    var minusIndex = 0
    
    line.enumerated().forEach { (index, char) in
        if knownColumnIndex.contains(index) {
            minusIndex += 1
        } else {
            if char.isWhitespace {
                if lines.contains(where: { !$0[$0.index($0.startIndex, offsetBy: index)].isWhitespace }) {
                    if noColumns.count <= (index-minusIndex) {
                        noColumns.append([])
                    }
                    noColumns[index-minusIndex].append(-1)
                } else {
                    knownColumnIndex.append(index)
                    minusIndex += 1
                }
            } else {
                if noColumns.count <= (index-minusIndex) {
                    noColumns.append([])
                }
                noColumns[index-minusIndex].append(Int(String(char))!)
            }
        }
    }
}

let lastLine = lines.last!.split(separator: " ")

lastLine.enumerated().forEach { (index, char) in
    operations.append(Operation(rawValue: String(char))!)
    
}

func calculate(_ numbers: [Int], with operation: Operation) -> Int {
    print("CALC: \(operation), NUm: \(numbers)")
    switch operation {
    case .add:
        return numbers.reduce(0, +)
    case .mult:
        return numbers.reduce(1, *)
    }
}

var amount = 0

let numbersPerGroup: Int = noColumns.first!.count

var tmpNumbers: [Int] = []
print(numbersPerGroup)
print(noColumns.count)
print(operations.count)
noColumns.enumerated().forEach { (index, values) in
    // there 2 groups as well ... need to check on different way .... 
    if index.isMultiple(of: numbersPerGroup) && index != 0 {
        print("INDEX: \(index)")
        amount += calculate(tmpNumbers, with: operations[(index/numbersPerGroup)-1])
        tmpNumbers = []
    }

    let stringNumber = values.reduce("") { partialResult, number in
        if number == -1 {
            return partialResult
        } else {
            return "\(partialResult)\(number)"
        }
    }
    
    tmpNumbers.append(Int(stringNumber)!)
}

amount += calculate(tmpNumbers, with: operations.last!)

print(amount)
//  *   +    *  +   *   *   +    +
// 9995649 -> to low
// 57871575723073810 -> to high
// 49811430829229301 -> to high
