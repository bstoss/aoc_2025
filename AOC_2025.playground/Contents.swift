import Foundation

let fileUrl = Bundle.main.url(forResource: "day_8_test", withExtension: nil)!
let input = try! String(contentsOf: fileUrl, encoding: .utf8)

let lines = input.split(separator: "\n")

func debug(_ message: Any) {
    print(message)
}
//distance between 2 objects in 3d space
// d = √((x₂ - x₁)² + (y₂ - y₁)² + (z₂ - z₁)²)

struct JunctionBox: Hashable {
    let x: Int
    let y: Int
    let z: Int
    
    init(_ input: String) {
        let coords = input.split(separator: ",")
        x = Int(coords[0])!
        y = Int(coords[1])!
        z = Int(coords[2])!
    }
    
    var description: String {
        "\(x),\(y),\(z)"
    }
    
    func distance(to box: JunctionBox) -> Int {
        let dx = box.x - x
        let dy = box.y - y
        let dz = box.z - z
        return dx*dx + dy*dy + dz*dz
    }
}

extension JunctionBox: Equatable {
    static func ==(lhs: JunctionBox, rhs: JunctionBox) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y && rhs.z == lhs.z
    }
}

struct Circuit {
    var boxes: Set<JunctionBox>
}

struct Pair: Hashable {
    let boxA: Int
    let boxB: Int
    let distance: Int
}

var junctionBoxes: [(x: Int, y: Int, z: Int)] = lines.map {
    var coords = $0.split(separator: ",")
    return (x: Int(coords[0])!, y: Int(coords[1])!, z: Int(coords[2])!)
}
var countBoxes = junctionBoxes.count
var pairs: Set<Pair> = []
pairs.reserveCapacity(countBoxes * (countBoxes - 1) / 2)

print(Date())

for i in 0..<junctionBoxes.count {
    let (xi, yi, zi) = junctionBoxes[i]
    for j in (i+1)..<junctionBoxes.count {
        let (xj, yj, zj) = junctionBoxes[j]

        let dx = xi - xj
        let dy = yi - yj
        let dz = zi - zj
        let d = dx*dx + dy*dy + dz*dz
        pairs.insert(
            Pair(
                boxA: i,
                boxB: j,
                distance: d
            )
        )
    }
}

print("PARIS")
print(Date())

let sortedPairs = pairs.sorted(by: { $0.distance < $1.distance })
pairs = []
print("SORTED")
print(Date())

var circuits: [Set<Int>] = []
var merges = 0

for pair in sortedPairs {
    guard merges < 1000 else {
        break
    }
    print("PAIR")
    print("\(junctionBoxes[pair.boxA]) - \(junctionBoxes[pair.boxB]) - \(pair.distance)")
    
    if circuits.contains(where: { $0.contains(pair.boxA) && $0.contains(pair.boxB) })  {
        continue
    }
    
    if let firstIndex = circuits.firstIndex(where: { $0.contains(pair.boxA) || $0.contains(pair.boxB) }) {
        circuits[firstIndex].insert(pair.boxA)
        circuits[firstIndex].insert(pair.boxB)
    } else {
        circuits.append([pair.boxA])
    }
    
    merges += 1
}

print(Date())
print("DONE")

 
let sortedCircuits = circuits.sorted(by: { $0.count > $1.count })

sortedCircuits.forEach { circuit in
    print("CIRCUIT: \(circuit.count)")
}

let amountOfWires = sortedCircuits[0..<3].reduce(into: 1) { partialResult, circuit in
    print(circuit.count)
    partialResult *= circuit.count
}

print(amountOfWires)

//  4320 -> to low
/*
var circuits: [Circuit] = []
var junctionBoxes = lines.map { JunctionBox(String($0)) }
var toCheckAgainstBoxes = junctionBoxes.dropFirst()

for _ in 0...10 {
    var boxA = junctionBoxes[0]
    var boxB = toCheckAgainstBoxes[1]
    
    var shortest: Double = boxA.distance(to: boxB)
    for box in junctionBoxes {
        
        for checkAgainstBox in toCheckAgainstBoxes {
            guard box != checkAgainstBox else {
                continue
            }
            
            let distance = box.distance(to: checkAgainstBox)
            if distance < shortest {
                boxA = box
                boxB = checkAgainstBox
                shortest = distance
            }
        }
    }
    print("\(boxA) - \(boxB) - \(shortest)")
    toCheckAgainstBoxes.removeAll(where: { $0 == boxA || $0 == boxB })
    
    if let firstIndex = circuits.firstIndex(where: { $0.boxes.contains(boxA) || $0.boxes.contains(boxB) }) {
        circuits[firstIndex].boxes.insert(boxA)
        circuits[firstIndex].boxes.insert(boxB)
    } else {
        circuits.append(Circuit(boxes: [boxA, boxB]))
    }
}

circuits.sort(by: { $0.boxes.count > $1.boxes.count })


circuits.forEach { circuit in
    print("CIRCUIT: \(circuit.boxes.count)")
    circuit.boxes.forEach { box in
        print(box)
    }
}


let amountOfWires = circuits[0...3].reduce(into: 1) { partialResult, circuit in
    print(circuit.boxes.count)
    partialResult *= circuit.boxes.count
}

print(amountOfWires)
*/
/*
for box in junctionBoxes {
    
    let nearestBox = junctionBoxes.filter({ $0 != box }).sorted(
        by: {
            box.distance(to: $0) < box.distance(to: $1)
        }).first!
    
    print("\(box) -> \(nearestBox)")
}
*/
/*
 gehe jede junkbox durch
 nehm nun stetig die beiden nähesten und pack die zusammen
 
 */

//var circuits: [Circuit] = []
//
//for coord in coords {
//    debug("CHECK \(coord.description)")
//    var shortest: JunctionBox?
//    for coord2 in coords {
//        guard coord != coord2 else {
//            continue
//        }
//        
//        guard let currentShortest = shortest else {
//            shortest = coord2
//            continue
//        }
//        
//        debug("\(coord2.description)")
//        let distance = coord.distance(to: coord2)
//        let distanceToShortest = coord.distance(to: currentShortest)
//        
//        debug(distance)
//        
//        if distance < distanceToShortest {
//            debug("SET NEW SHORTEST")
//            shortest = coord2
//        }
//    }
//    
//    var circuit = Circuit(a: coord, b: shortest)
//    circuits.append(circuit)
//}
//
//print(circuits)
