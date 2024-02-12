//: [Previous](@previous)

import Foundation


let json = """
{
    "quote_content": "The will of man is his happiness.",
    "author_name": "Friedrich Schiller",
    "likelike": 34567
}
"""

// String -> Data -> Quote (디코딩, 역직렬화)
// 이 data를 Swift에서 사용하려고 할 거잉 ^_^

struct Quote: Decodable {
    let content: String
    let name: String
    let like: Int
    
    // 코딩키는 틀이 정해져 있어서 다른 걸 쓰면 안댐
    // 커스텀하게 쓰고 싶다!!! 라고 한다면 코딩키에 이런 식으로 rawValue를 선언해 주어야 함
    enum CodingKeys: String, CodingKey {
        case content = "quote_content"
        case name = "author_name"
        case like = "likelike"
    }
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


do {
    let value = try decoder.decode(Quote.self, from: result)
    print(value)
} catch {
    print(error)
}






//: [Next](@next)
