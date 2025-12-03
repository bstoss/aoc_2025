import Foundation

public func day3_1() {
    let fileUrl = Bundle.main.url(forResource: "day_3_test", withExtension: nil)!
    let input = try! String(contentsOf: fileUrl, encoding: .utf8)

    let banks = input.split(separator: "\n")

    var result = 0
    banks.forEach { bank in
        
        var highest = 0
        bank.enumerated().forEach { index, joltage in
            
            bank[bank.index(bank.startIndex, offsetBy: index+1)...].forEach { char in
                let sumJoltage = Int("\(joltage)\(char)")!
                if sumJoltage > highest {
                    highest = sumJoltage
                }
            }
            
        }
        
        result += highest
        
    }

    print(result)
}


public func day3_2() {
    
    let fileUrl = Bundle.main.url(forResource: "day_3_source", withExtension: nil)!
    let input = try! String(contentsOf: fileUrl, encoding: .utf8)

    let banks = input.split(separator: "\n")

    var result = 0
    banks.forEach { bank in
        
        let max = maxJoltage(forBank: String(bank))
        debug("RESULT: \(max)")
        result += max
        
    }

    func debug(_ message: Any) {
        //print(message)
    }

    func maxJoltage(forBank bank: String) -> Int {
        
        var highest = 0
        var currentHighestIndex = -1
        
        for i in 0..<12 {
            let (checkHighest, highestIndex) = maxJoltage(
                startingWith: i,
                currentNumber: highest,
                currentHighestIndex: currentHighestIndex,
                inBank: bank
            )
            
            if checkHighest > highest {
                highest = checkHighest
                currentHighestIndex = highestIndex
            }
            
        }
        
        return highest
    }

    func maxJoltage(startingWith index: Int, currentNumber number: Int, currentHighestIndex: Int, inBank bank: String) -> (Int, Int) {
        
        var highest = 0
        var highestIndex = 0
        let amountOfBatteries = bank.count
        debug("INDEX: \(index)")
        
        for (bankIndex, jolatge) in bank.enumerated() {
            debug("CHECK INDEX: \(bankIndex) - JOLTAGE: \(jolatge)")
            
            guard bankIndex > currentHighestIndex else {
                debug("BANKINDEX LOWER THAN HIGHEST INDEX: \(bankIndex)")
                continue
            }
            
            guard bankIndex >= index else {
                debug("BANKINDEX TO LOW: \(bankIndex)")
                continue
            }
            
            guard amountOfBatteries-bankIndex >= (12-index) else {
                debug("REACHED END OF POSSIBLE NUMBERS - RestBATTS: \(amountOfBatteries-bankIndex)")
                break
            }
            
            // get rest of zeros
            let mult = Int(pow(10.0, 11.0-Double(index)))
            let maxBase = number + Int(String(jolatge))! * mult
            
            guard maxBase > highest else {
                debug("NEW BASE TO LOW: \(maxBase) - \(highest)")
                continue
            }
            highest = maxBase
            highestIndex = bankIndex
            debug("HIGHEST: \(highest)")
        }

        return (highest, highestIndex)
    }

    print(result)

}
