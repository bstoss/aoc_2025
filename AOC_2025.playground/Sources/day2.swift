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
                
                var current = ""
                
                for char in stringId {
                    
                    current += String(char)
                    
                    guard current.count <= stringId.count/2 else { break }
                    
                    if stringId.replacingOccurrences(of: current, with: "").count == 0
                    && current.count <= stringId.count/2 {
                        result += id
                        break
                    }
                }
            }
        }
            
        print(result)
    } catch {
        print(error)
    }
}
