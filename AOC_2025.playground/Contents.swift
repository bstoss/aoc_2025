import Foundation


//distance between 2 objects in 3d space
// d = √((x₂ - x₁)² + (y₂ - y₁)² + (z₂ - z₁)²)

struct JunctionBox {
    let x: Float
    let y: Float
    let z: Float
    
    init(_ input: String) {
        var coords = input.split(separator: ",")
        x = Float(coords[0])!
        y = Float(coords[1])!
        z = Float(coords[2])!
    }
    
    var description: String {
        "\(x),\(y),\(z)"
    }
    
    func distance(to box: JunctionBox) -> Double {
        let dx = box.x - x
        let dy = box.y - y
        let dz = box.z - z
        return sqrt(Double(pow(dx, 2) + pow(dy, 2) + pow(dz, 2)))
    }
    
    
}

extension JunctionBox: Equatable {
    static func ==(lhs: JunctionBox, rhs: JunctionBox) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y && rhs.z == lhs.z
    }
}

let input = """
162,817,812
57,618,57
906,360,560
592,479,940
352,342,300
466,668,158
542,29,236
431,825,988
739,650,466
52,470,668
216,146,977
819,987,18
117,168,530
805,96,715
346,949,466
970,615,88
941,993,340
862,61,35
984,92,344
425,690,689
"""

var lines = input.split(separator: "\n")
var coords = lines.map { JunctionBox(String($0)) }
func debug(_ message: Any) {
    print(message)
}

for coord in coords {
    debug("CHECK \(coord.description)")
    for coord2 in coords {
        guard coord != coord2 else {
            continue
        }
        debug("\(coord2.description)")
        debug(coord.distance(to: coord2))
    }
}
