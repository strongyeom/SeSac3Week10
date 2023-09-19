//
//  SesacAPI.swift
//  SeSac3Week10
//
//  Created by 염성필 on 2023/09/19.
//

import Foundation
import Alamofire

// URL 구조화 - URLRequestConvertible ( Alamofire에 내장되어 있는 메서드 ) : 커뮤니케이션 용이

enum SesacAPI {
    static let key = "R87kkJUhEVTR_QPQo8pQOj7Q7sgWnUP8gTE8h0yOHB0"
    
    // 연관값은 필요할때만 꺼내서 사용하면 됨 query 연산 프로퍼티에서만 사용하니까 그때만 사용
    case search(query: String) // 
    case random
    // ID에 따라서 달라지기 때문에... 상수를 만들어서 매개변수 처럼 사용할 수 있음 -> 연관값 associated value
    case detailPhoto(id: String)
    
    // endPoint에서 URL로 바뀌기 때문에 String으로 설정
    var baseURL: String {
        return "https://api.unsplash.com/search/photos"
        // 조건에 따라 다양한 baseURL이 있을 수 있음
//        switch self {
//        case .search, .random:
//            <#code#>
//        case .random:
//            <#code#>
//        case .detailPhoto:
//            <#code#>
//        }
//
    }
    
    var endPoint: URL {
        switch self {
        case .search:
            return URL(string: baseURL + "search/photos")!
        case .random:
            return URL(string: baseURL + "photos/random")!
        case .detailPhoto(let id):
            return URL(string: baseURL + "photos/\(id)")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(SesacAPI.key)"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var query: [String: String] {
        switch self {
        case .search(let query):
            return ["query": query]
        case .random, .detailPhoto(_):
            // 빈값을 적용해준다.
            return ["":""]
        }
    }
}
