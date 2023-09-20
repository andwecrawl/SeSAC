//
//  NetworkErrors.swift
//  Cheers!
//
//  Created by yeoni on 2023/09/20.
//

import Foundation

enum NetworkError: Int, Error {
    case missingParameter = 400
    case unauthorized = 401
    case permissionDenied = 403
    case invaildServer = 500
    
    var errorDescription: String {
        switch self {
        case .missingParameter:
            return "잘못된 요청입니다"
        case .unauthorized:
            return "인증 정보가 없습니다"
        case .permissionDenied:
            return "권한이 없습니다"
        case .invaildServer:
            return "서버 점검 중입니다"
        }
    }
}
