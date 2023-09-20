//
//  Router.swift
//  SeSac3Week10
//
//  Created by 염성필 on 2023/09/20.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    private static let key = "R87kkJUhEVTR_QPQo8pQOj7Q7sgWnUP8gTE8h0yOHB0"
    
    // 연관값은 필요할때만 꺼내서 사용하면 됨 query 연산 프로퍼티에서만 사용하니까 그때만 사용
    case search(query: String) //
    case random
    // ID에 따라서 달라지기 때문에... 상수를 만들어서 매개변수 처럼 사용할 수 있음 -> 연관값 associated value
    case detailPhoto(id: String)
    
    // endPoint에서 URL로 바뀌기 때문에 String으로 설정
    private var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    // 외부에서 사용하지 않기 때문에 접근제어자 private 설정
    private var endPoint: URL {
        switch self {
        case .search:
            return URL(string: baseURL + "search/photos")!
        case .random:
            return URL(string: baseURL + "photos/random")!
        case .detailPhoto(let id):
            return URL(string: baseURL + "photos/\(id)")!
        }
    }
    
    // asURLRequest() 만 외부에서 사용할 것이기 때문에 그 외의 프로퍼티는 private으로 설정해준다.
    func asURLRequest() throws -> URLRequest {
        
        
        // 내부에서 만들어 놓은 url : endPoint 사용
        var request = URLRequest(url: endPoint)
        
        return request
    }
    
    
}
