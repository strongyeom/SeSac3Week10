//
//  SesacAPI.swift
//  SeSac3Week10
//
//  Created by 염성필 on 2023/09/19.
//

import Foundation

// URL 구조화 - URLRequestConvertible ( Alamofire에 내장되어 있는 메서드 ) : 커뮤니케이션 용이

enum SesacAPI {
    static let key = "R87kkJUhEVTR_QPQo8pQOj7Q7sgWnUP8gTE8h0yOHB0"
    
    case search
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
}
