import Foundation

public func day6_1() {
    let fileUrl = Bundle.main.url(forResource: "day_6_source", withExtension: nil)!
    let input = try! String(contentsOf: fileUrl, encoding: .utf8)

    let lines = input.split(separator: "\n")

    enum Operation: String {
        case add = "+"
        case mult = "*"
    }

    var numbers: [[Int]] = []
    var operations: [Operation] = []
    for line in lines {
        var values = line.split(separator: " ")
        
        values.enumerated().forEach { (index, value) in
            if let number = Int(value) {
                if numbers.count <= index {
                    numbers.append([])
                }
                numbers[index].append(number)
            } else {
                operations.append(Operation(rawValue: String(value))!)
            }
        }
    }

    func calculate(_ numbers: [Int], with operation: Operation) -> Int {
        switch operation {
        case .add:
            return numbers.reduce(0, +)
        case .mult:
            return numbers.reduce(1, *)
        }
    }

    var amount = 0

    numbers.enumerated().forEach { (index, values) in
        amount += calculate(values, with: operations[index])
    }
    print(amount)
}


public func day6_2() {
    let fileUrl = Bundle.main.url(forResource: "day_6_source", withExtension: nil)!
    let input = try! String(contentsOf: fileUrl, encoding: .utf8)

    let lines = input.split(separator: "\n")

    enum Operation: String {
        case add = "+"
        case mult = "*"
    }

    var operations: [Operation] = []
    var numbersPerGroup: [Int] = []
    var noColumns: [[Int]] = []
    var knownColumnIndex: [Int] = []
    for line in lines.dropLast() {
        
        var minusIndex = 0
        var numbers = 0
        line.enumerated().forEach { (index, char) in
            if knownColumnIndex.contains(index) {
                minusIndex += 1
                numbers = 0
            } else {
                if char.isWhitespace {
                    if lines.contains(where: { !$0[$0.index($0.startIndex, offsetBy: index)].isWhitespace }) {
                        if noColumns.count <= (index-minusIndex) {
                            noColumns.append([])
                        }
                        noColumns[index-minusIndex].append(-1)
                        numbers += 1
                    } else {
                        knownColumnIndex.append(index)
                        numbersPerGroup.append(numbers)
                        minusIndex += 1
                        numbers = 0
                    }
                } else {
                    if noColumns.count <= (index-minusIndex) {
                        noColumns.append([])
                    }
                    noColumns[index-minusIndex].append(Int(String(char))!)
                    numbers += 1
                }
            }
        }
        
        if knownColumnIndex.count == numbersPerGroup.count {
            numbersPerGroup.append(numbers)
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
    var tmpNumbers: [Int] = []
    var currentGroup = 0
    print(numbersPerGroup)
    print(noColumns.count)
    print(operations.count)
    noColumns.enumerated().forEach { (index, values) in

        let nextEnd = numbersPerGroup[0...currentGroup].reduce(0, +)
        if index == nextEnd {
            amount += calculate(tmpNumbers, with: operations[currentGroup])
            tmpNumbers = []
            currentGroup += 1
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
}
