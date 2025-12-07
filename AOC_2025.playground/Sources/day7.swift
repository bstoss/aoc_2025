import Foundation

public func day7_1() {
    
    let fileUrl = Bundle.main.url(forResource: "day_7_source", withExtension: nil)!
    let input = try! String(contentsOf: fileUrl, encoding: .utf8)

    let lines = input.split(separator: "\n").map(String.init)

    var telePaths: Set<Int> = []
    var amountOfSplits = 0
    lines.enumerated().forEach { (index, line) in
        
        print("LINE \(index)")
        
        var tmpNewPaths: Set<Int> = []
        line.enumerated().forEach { (index, char) in
            if char == "S" {
                print("FOUND S AT INDEX \(index)")
                tmpNewPaths = [index]
            } else if char == "^" {
                print("FOUND ^ AT INDEX \(index)")
                if telePaths.contains(index) {
                    print(telePaths)
                    print("Set new path \(index-1) \(index+1)")
                    tmpNewPaths.insert(index-1)
                    tmpNewPaths.insert(index+1)
                    amountOfSplits += 1
                }
            } else if telePaths.contains(index) {
                tmpNewPaths.insert(index)
            }
        }
        if !tmpNewPaths.isEmpty {
            telePaths = tmpNewPaths
        }
        print("SPLITS \(amountOfSplits)")
    }

    print(telePaths)
    print(telePaths.count)
    print(amountOfSplits)
}

public func day7_2() {
    let fileUrl = Bundle.main.url(forResource: "day_7_source", withExtension: nil)!
    let input = try! String(contentsOf: fileUrl, encoding: .utf8)

    let lines = input.split(separator: "\n").map(String.init)

    func debug(_ message: Any) {
        //print(message)
    }

    var telePaths: [(Int, Int)] = []
    var amountOfPaths = 1
    lines.enumerated().forEach { (index, line) in
        
        debug("LINE \(index)")
        
        var tmpNewPaths: [(Int, Int)] = []
        line.enumerated().forEach { (index, char) in
            if char == "S" {
                debug("FOUND S AT INDEX \(index)")
                telePaths = [(index, 1)]
            } else if char == "^" {
                debug("FOUND ^ AT INDEX \(index)")
                if let path = telePaths.first(where: { $0.0 == index }) {
                    debug(telePaths)
                    debug(tmpNewPaths)
                    debug("Set new path \(index-1) \(index+1)")
                    
                    let leftIndex = index-1
                    let rightIndex = index+1
                    
                    if let existLIndex = tmpNewPaths.firstIndex(where: { $0.0 == leftIndex }) {
                        tmpNewPaths[existLIndex].1 += path.1
                    } else {
                        tmpNewPaths.append((leftIndex, path.1))
                    }
                    
                    if let existRIndex = tmpNewPaths.firstIndex(where: { $0.0 == rightIndex }) {
                        tmpNewPaths[existRIndex].1 += path.1
                    } else {
                        tmpNewPaths.append((rightIndex, path.1))
                    }
                    debug(tmpNewPaths)
                    amountOfPaths += path.1
                }
            } else if let path = telePaths.first(where: { $0.0 == index }) {
                debug("NO CHAR, APPEND")
                if let existsIndex = tmpNewPaths.firstIndex(where: { $0.0 == index }) {
                    tmpNewPaths[existsIndex].1 += path.1
                } else {
                    tmpNewPaths.append(path)
                }
                debug(tmpNewPaths)
            }
        }
        
        debug(telePaths)
        debug(tmpNewPaths)
        if !tmpNewPaths.isEmpty {
            telePaths = tmpNewPaths
        }
        debug("PATHS \(amountOfPaths)")
    }



    debug(telePaths)
    debug(telePaths.count)
    print(amountOfPaths)
}
