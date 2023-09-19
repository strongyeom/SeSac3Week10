//
//  Network.swift
//  SeSac3Week10
//
//  Created by 염성필 on 2023/09/19.
//

import Foundation
import Alamofire

class Network {
    
    static let shared = Network()
    
    private init() { }
    
    // <T: 제약조건>만 들어오게끔 설정 -> 메서드 확장성 증가
    // type 매겨변수를 만들어서 T를 대응 "고래밥" -> String -> String.Type
    func request<T: Decodable>(type: T.Type, api: SesacAPI, completionHandler: @escaping(Result<T, SeSacError>) -> Void) { // search Photo
    
        AF.request(api.endPoint, method: api.method, parameters: api.query, encoding: URLEncoding(destination: .queryString),headers: api.header)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completionHandler(.success(data)) // 성공에 대한 데이터만 던짐
                case .failure(_):
                    // response.response?에서 만약에 nil이 나오면 500을 리턴 해준다.
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSacError(rawValue: statusCode) else { return }
                    completionHandler(.failure(error)) // 실패에 대해서만 던짐
                }
            }
    }
}
