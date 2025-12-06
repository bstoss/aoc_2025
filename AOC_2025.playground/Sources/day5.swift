import Foundation

public func day5_1() {
    
    let fileUrl = Bundle.main.url(forResource: "day_5_source", withExtension: nil)!
    let input = try! String(contentsOf: fileUrl, encoding: .utf8)

    var lines = input.split(separator: "\n")

    var ranges: [(Int, Int)] = []
    var ids: [Int] = []
    for line in lines {
        if line.contains("-") {
            let range = line.split(separator: "-")
            ranges.append((Int(range[0])!, Int(range[1])!))
        } else {
            ids.append(Int(line)!)
        }
    }

    var fresh = 0

    for id in ids {
        for range in ranges {
            if id >= range.0 && id <= range.1 {
                fresh += 1
                break
            }
        }
    }

    print(fresh)
}

public func day5_2() {
    
    let fileUrl = Bundle.main.url(forResource: "day_5_source", withExtension: nil)!
    let input = try! String(contentsOf: fileUrl, encoding: .utf8)

    var lines = input.split(separator: "\n")

    var amountOfFresh = 0
    var ranges: [ClosedRange<Int>] = []

    for line in lines {
        if line.contains("-") {
            let range = line.split(separator: "-")
            let from = Int(range[0])!
            let to = Int(range[1])!
                    
            ranges.append((from...to))
        }
    }


    func mergeRanges(
        withRange range: ClosedRange<Int>,
        inList list: [ClosedRange<Int>]
    ) -> (Bool, [ClosedRange<Int>]) {
        
        var newStored: [ClosedRange<Int>] = []
        var didOverlap = false
        for item in list {
            guard range.overlaps(item) else {
                newStored.append(item)
                continue
            }
            
            didOverlap = true
            let newLower = min(range.lowerBound, item.lowerBound)
            let newUpper = max(range.upperBound, item.upperBound)
            newStored.append((newLower...newUpper))
        }
        
        return (didOverlap ,newStored)
    }

    // loop ranges, merge overlapping, sote new list, do it again
    var loopAgain = true
    while loopAgain {
        loopAgain = false
        
        var newRanges: [ClosedRange<Int>] = []
        for range in ranges {
            var merge = mergeRanges(withRange: range, inList: newRanges)
            
            if merge.0 {
                loopAgain = true
                newRanges = merge.1
            } else {
                newRanges.append(range)
            }
        }
        
        ranges = newRanges
    }

    for range in ranges {
        amountOfFresh += range.count
    }

    print("AMOUNT: \(amountOfFresh)")
}
