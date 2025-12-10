import Foundation

func debug(_ message: Any) {
//    print(message)
}

struct Pair: Hashable {
    let boxA: Int
    let boxB: Int
    let distance: Int
}

@MainActor
var junctionBoxes: [(x: Int, y: Int, z: Int)] = []

@MainActor
var circuits: [Set<Int>] = []

@MainActor
var sortedPairs: [Pair] = []


@MainActor
public func prepareDay8() {
    let fileUrl = Bundle.main.url(forResource: "day_8_source", withExtension: nil)!
    let input = try! String(contentsOf: fileUrl, encoding: .utf8)

    let lines = input.split(separator: "\n")

   
    //distance between 2 objects in 3d space
    // d = √((x₂ - x₁)² + (y₂ - y₁)² + (z₂ - z₁)²)

    junctionBoxes = lines.map {
        var coords = $0.split(separator: ",")
        return (x: Int(coords[0])!, y: Int(coords[1])!, z: Int(coords[2])!)
    }
    var countBoxes = junctionBoxes.count
    var pairs: Set<Pair> = []
    pairs.reserveCapacity(countBoxes * (countBoxes - 1) / 2)

    print("START")
    print(Date())

    for i in junctionBoxes.indices {
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

    print("PAARE done")
    print(Date())

    sortedPairs = pairs.sorted(by: { $0.distance < $1.distance })
    pairs = []
    print("SORTED")
    print(Date())

    circuits = junctionBoxes.indices.map({ [$0] })

}

@MainActor
public func day8_1() {
    
    prepareDay8()
    
    // for test source
     for _ in 0..<10 {
//    for _ in 0..<1000 {
        
        let pair = sortedPairs.removeFirst()
        debug("PAIR")
        
        let circuitsToConnect = circuits.filter {
            $0.contains(pair.boxA) || $0.contains(pair.boxB)
        }
        
        debug(circuitsToConnect)
        
        if circuitsToConnect.count == 2 {
            circuits.removeAll(where: { $0 == circuitsToConnect[0] || $0 == circuitsToConnect[1] })
            circuits.append(contentsOf: [circuitsToConnect[0].union(circuitsToConnect[1])])
        }
    }

    print("Circuites ONE")
    print(Date())
     
    let sortedCircuits = circuits.sorted(by: { $0.count > $1.count })

    let amountOfWires = sortedCircuits[0..<3].reduce(into: 1) { partialResult, circuit in
        debug(circuit.count)
        partialResult *= circuit.count
    }

    print(amountOfWires)

}

@MainActor
public func day8_2() {
    prepareDay8()
    
    var distanceOfLastPairs: Int = 0
    
    while circuits.count > 1 {
        
        let pair = sortedPairs.removeFirst()
        debug("PAIR")
        
        let circuitsToConnect = circuits.filter {
            $0.contains(pair.boxA) || $0.contains(pair.boxB)
        }
        
        debug(circuitsToConnect)
        
        if circuitsToConnect.count == 2 {
            if circuits.count == 2 {
                distanceOfLastPairs = junctionBoxes[pair.boxA].x * junctionBoxes[pair.boxB].x
            }
            
            circuits.removeAll(where: { $0 == circuitsToConnect[0] || $0 == circuitsToConnect[1] })
            circuits.append(contentsOf: [circuitsToConnect[0].union(circuitsToConnect[1])])
        }
    }
    
    print(distanceOfLastPairs)
}
