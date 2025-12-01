import java.io.File

val text = File("AOC_2025.playground/Resources/day_1_source").readText()
val lines = text.lines()


var current = 50
var numOfZeros = 0
lines.forEach { line ->
    val before = current
    val direction = line.first()
    val num = line.drop(1).toInt()

    if (direction == 'R') {
        current += num
        while (current > 99) {
            current -= 100
            numOfZeros += 1
        }
    } else {
        current -= num

        if (current == 0) {
            numOfZeros += 1
        } else {
            if (current < 0) {
                while (current < 0) {
                    current += 100
                    numOfZeros += 1
                }

                if (before == 0) {
                    numOfZeros -= 1
                }
            } 

            if (current == 0) {
                numOfZeros += 1
            }
            
        }
    }
}

println(numOfZeros)