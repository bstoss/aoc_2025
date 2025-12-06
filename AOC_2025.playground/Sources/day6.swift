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
