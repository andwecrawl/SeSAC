//: [Previous](@previous)

import Foundation

let json = """
{
    "quote": "The will of man is his happiness.",
    "author": "Friedrich Schiller",
    "category": "happiness"
}
"""

// String -> Data -> Quote (디코딩, 역직렬화)
// 이 data를 Swift에서 사용하려고 할 거잉 ^_^

struct Quote: Decodable {
    let quote: String
    let author: String
    let category: String
}


// 1. String to Data
guard let result = json.data(using: .utf8) else {
    fatalError("Error!")
    // 의도적으로 런타임 오류를 내는 칭구임
}

print(result)
dump(result)


let apple = [[1, 2, 3], [4, 5, 6]]

print(apple)
dump(apple)


// Data => Quote
// Error Handling, Do Try Catch, Meta type
do {
    let value = try JSONDecoder().decode(Quote.self, from: result)
    print(value)
    print(value.author)
} catch {
    print(error)
}



//: [Next](@next)
