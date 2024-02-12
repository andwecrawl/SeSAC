//
//  main.swift
//  0x002
//
//  Created by yeoni on 2023/10/26.
//

import Foundation

// https://www.acmicpc.net/problem/2178


// 강의 자료의 queue!!

/*
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
*/




let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
let n = input[0]
let m = input[1]

var board: [[Int]] = []
var vis: [[Int]] = .init(repeating: .init(repeating: -1, count: m), count: n)

let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]

for _ in 0..<n {
    var line = readLine()!.map({ Int(String($0))! })
    board.append(line)
}

//var queue = Queue<(Int, Int)>()
var queue: [(Int, Int)] = [] // 야매 큐
var index = 0
queue.append((0, 0))
vis[0][0] = 1

while queue.count >= index + 1 {
//while queue.isEmpty {
//    let cur = queue.dequeue()
    let cur = queue[index]
    index += 1
    for dir in 0..<4 {
        let ny = cur.0 + dy[dir]
        let nx = cur.1 + dx[dir]
        
        if ny < 0 || ny >= n || nx < 0 || nx >= m { continue } // index 오류가 나는 애들
        if vis[ny][nx] != -1 { continue } // -1이 아닌 경우! (이미 방문함) pass
        if board[ny][nx] == 0 { continue } // 0인 경우 skip!!
        
//        queue.enqueue((ny, nx))
        queue.append((ny, nx))
        
        vis[ny][nx] = vis[cur.0][cur.1] + 1
    }
}

print(vis)
print(vis[n-1][m-1])


//var visited: [Int]
//
//func BFS(startNode: Int) {
//    var queue: [Int] = []
//    var index = 0
//    
//    queue.append(startNode)
//    visited[startNode] = true
//    
//    while index < queue.count
//}


struct Stack<T> {
    private var elements: [T] = []
    init() { }
    
    mutating func push(with element: T) {
        elements.append(element)
    }
    
    mutating func pop(with element: T) {
        elements.popLast()
    }
    
    // elements에 요소가 있는 경우 마지막 요소 반환 / 없으면 nil
    func peek() -> T? {
        return elements.last
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
}


struct Queue<T> {
    private var elements: [T] = []
    private var index = 0
    init() { }
    
    mutating func enqueue(with element: T) {
        elements.append(element)
    }
    
    mutating func dequeue(with element: T) -> T? {
        if index < count {
            let value = elements[index]
            index += 1
            return value
        } else {
            return nil
        }
    }
    
    func peek() -> T? {
        return index < count ? elements[index] : nil
    }
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    var count: Int {
        elements.count
    }
}
