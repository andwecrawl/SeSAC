//: [Previous](@previous)

import Foundation


let json = """
{
    "quote_content": "The will of man is his happiness.",
    "author_name": "Friedrich Schiller",
}
"""

// String -> Data -> Quote (디코딩, 역직렬화)
// 이 data를 Swift에서 사용하려고 할 거잉 ^_^

struct Quote: Decodable {
    let quoteContent: String
    let authorName: String
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
// 우리가 정한 친구에 알맞게 넣어주는 친구 => jsonDecorder

let decoder = JSONDecoder()
// 호오 ........... 스네이크케이스로 구성되어있는 친구를 알맞게 디코딩해주는 친구임
// 제약이 있기는 하지만 스네이크 정도는 해결 가능~!
// 근데 우리가 결론적으로 원하는 상황은 아예 다른 key를 사용하더라도 데이터를 넣고 싶은 거잉
decoder.keyDecodingStrategy = .convertFromSnakeCase


do {
    let value = try decoder.decode(Quote.self, from: result)
    print(value)
} catch {
    print(error)
}





//: [Next](@next)
