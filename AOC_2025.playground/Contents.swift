import Foundation

public func day2() {

    do {
        let fileUrl = Bundle.main.url(forResource: "day_2_source", withExtension: nil)!
        let input = try String(contentsOf: fileUrl, encoding: .utf8).replacingOccurrences(of: "\n", with: "")
        
        let idRanges = input.split(separator: ",")
        
        var result = 0
        for idRange in idRanges {
            
            let ids = idRange.split(separator: "-").map { Int($0)! }
            
            for id in ids[0]...ids[1] {
                var stringId = "\(id)"
                guard stringId.count % 2 == 0 else { continue }
                
                let first = stringId.dropFirst(stringId.count/2)
                let last = stringId.dropLast(stringId.count/2)
                
                if first == last {
                    result += id
                }
            }
        }
        
        print(result)
    } catch {
        print(error)
    }
}

day2()
