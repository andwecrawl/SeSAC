import Foundation

// MARK: - Simple Queue
struct Queue<T> {
  var elements: [T] = []
  var index = 0 // front pointer

  var isEmpty: Bool {
    elements.count < index + 1
  }

  mutating func enqueue(_ data: T) {
    elements.append(data)
  }

  mutating func dequeue() -> T {
    let value = elements[index]
    index += 1
    return value
  }
}

func boardPrint(board: [[Int]]) {
  for y in 0..<board.count {
    for x in 0..<board[0].count {
      print(board[y][x], terminator: " ")
    }
    print("")
  }
}

var board: [[Int]] = [
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0],
  [0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0],
  [0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0],
  [0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0],
  [0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0],
  [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
]
let w = board[0].count
let h = board.count

print("----------------")
print("inital board:")
boardPrint(board: board)

// Start Point = (4, 5)
// 상하좌우 이동!!
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]

var queue = Queue<(Int, Int)>()
var vis: [[Bool]] = .init(
  repeating: .init(repeating: false, count: w), count: h
 queue가 Visited => true


queue.enqueue((4, 5))

let cur = queue.dequeue()
board[cur.0][cur.1] = 1

  for dir in 0...4 {
      let ny = cur.0 + dy[dir]
      let nx = cur.0 + dx[dir]
      
      if vis[ny][nx] { continue }
      if board[ny][nx] == 1 { continue}
      if my < 0 || ny >= h || nx < 0 || nx >= w { continue}
      
      queue.enqueue(ny, nx)
      vis[ny][nx] = true
  }
  
  print("============")
  print("final board")
  boardPrint(board: board)
  w졸앗어요
