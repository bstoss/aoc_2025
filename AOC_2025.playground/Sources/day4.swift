import Foundation

struct Position: Equatable {
    let x: Int
    let y: Int
}

extension Position: Hashable {}

enum CellType: Character {
    case empty = "."
    case rollOfPaper = "@"
}

public func day4() {
    let fileUrl = Bundle.main.url(forResource: "day_4_source", withExtension: nil)!
    let input = try! String(contentsOf: fileUrl, encoding: .utf8)
    let lines = input.split(separator: "\n")

    func adjacentCellTypes(forPosition position: Position) -> [CellType] {
        var cells: [CellType?] = []
        
        cells.append(grid[Position(x: position.x-1, y: position.y-1)])
        cells.append(grid[Position(x: position.x, y: position.y-1)])
        cells.append(grid[Position(x: position.x+1, y: position.y-1)])
        cells.append(grid[Position(x: position.x-1, y: position.y)])
        cells.append(grid[Position(x: position.x+1, y: position.y)])
        cells.append(grid[Position(x: position.x-1, y: position.y+1)])
        cells.append(grid[Position(x: position.x, y: position.y+1)])
        cells.append(grid[Position(x: position.x+1, y: position.y+1)])
        
        return cells.compactMap { $0 }
    }

    var grid: [Position: CellType] = [:]

    for i in 0..<lines.count {
        for j in 0..<lines[i].count {
            let line = lines[i]
            let cellType = CellType(rawValue: line[line.index(line.startIndex, offsetBy: j)])!
            grid[Position(x: i, y: j)] = cellType
        }
    }

    var numberOfAccessableRolls = 0
    var changed = true
    while changed {
        changed = false
        for cell in grid {
            guard cell.value == .rollOfPaper else {
                continue
            }
            let adjacents = adjacentCellTypes(forPosition: cell.key)
            if adjacents.filter({ $0 == .rollOfPaper }).count < 4 {
                numberOfAccessableRolls += 1
                grid[cell.key] = .empty
                changed = true
            }
        }
    }

    print(numberOfAccessableRolls)
}
