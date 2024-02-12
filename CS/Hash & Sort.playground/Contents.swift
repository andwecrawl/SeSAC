import Foundation

func solution( _ players: [String], _ callings: [String]) -> [String] {
    
//     var players: [String] = players
    
//     for call in callings {
//         var rank = 0
//         for i in 0..<players.count {
//             if players[i] == call {
//                 rank = i
//             }
//         }
//         players.swapAt(rank, rank-1)
//     }
    
//     return players
    
    var dic: [String: Int] = [:] // 누가 몇등인지
    var players = players
    
    for i in 0..<players.count {
        dic[players[i]] = i
     }
    
    for call in callings {
        let rank = dic[call]!
        let tempPlayer = players[rank - 1] // 앞사람
        players[rank - 1] = players[rank]
        players[rank] = tempPlayer

        dic[tempPlayer]! += 1
        dic[call]! -= 1
    }
    
    return players
}
