import UIKit

// weak가 왜 필요한지!!
// 안 쓸 때는 어덯게 하는지!!
//
class Guild {
    var name: String // 길드 이름
    unowned var owner: User?
    
    init(name: String) {
        self.name = name
        print("Guild Init")
    }
    
    deinit {
        print("Guild Deinit")
    }
}

class User {
    var nickname: String
    var guild: Guild?
    
    init(nickname: String) {
        self.nickname = nickname
        print("User Init")
    }
    
    deinit {
        print("User Deinit")
    }
}


// AutoReferenceCounting
var nickname: User? = User(nickname: "행복한해파리") // RC: +1
var guild: Guild? = Guild(name: "찌릿") // RC: +1

nickname?.guild = guild
guild?.owner = nickname

//nickname?.guild = nil // RC -1
//guild?.owner = nil // RC -1

nickname = nil
//guild = nil

//guild?.owner












