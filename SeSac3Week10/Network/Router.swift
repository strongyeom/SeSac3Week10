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
    // URL 타입으로 설정
    private var baseURL: URL {
        return URL(string: "https://api.unsplash.com/")!
    }
    
    // 외부에서 사용되지 않기 위해 접근제어자 private 설정
    // path로 설정해서 url 구조 파악
    private var path: String {
        switch self {
        case .search:
            return "search/photos"
        case .random:
            return "photos/random"
        case .detailPhoto(let id):
            return "photos/\(id)"
        }
    }
    
    private var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(Router.key)"]
    }
    
    private var method: HTTPMethod {
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
    
    // asURLRequest() 만 외부에서 사용할 것이기 때문에 그 외의 프로퍼티는 private으로 설정해준다.
    func asURLRequest() throws -> URLRequest {
        
        // 백업 복구 기능 했을때 appendingPathComponent: path를 명확하게 붙이겠다 사용했었음
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        // 헤더 및 메서드 추가
        request.headers = header
        request.method = method
        
        // encoding ~ 했던것 처럼 추가 코드 필요, 오픈 API 사용시 destination: .methodDependent 많이 씀
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(query, into: request)
        
        // 내부에서 만들어 놓은 url : endPoint 사용
       // var request = URLRequest(url: url)
        
        return request
    }
    
    
}
