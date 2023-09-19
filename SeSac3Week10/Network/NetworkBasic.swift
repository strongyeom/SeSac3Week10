//
//  NetworkBasic.swift
//  SeSac3Week10
//
//  Created by 염성필 on 2023/09/19.
//

import Foundation
import Alamofire

// 다양한 Error를 custom하게 만들 수 있음 , 상태코드에 대한 Error
enum SeSacError: Int, Error, LocalizedError {
    case unauthorized  = 401
    case permissionDenied = 403
    case invalidServer = 500
    case missingParameter = 400
    
    var errorDescription: String {
        switch self {
        case .unauthorized:
            return "인증되지 않았습니다."
        case .permissionDenied:
            return "올바르지 않은 권한 입니다."
        case .invalidServer:
            return "서버 점검 중입니다."
        case .missingParameter:
            return "검색어를 입력해주세요"
        }
    }
}



// final : 암묵적으로 상속이 안되고 재정의도 안되서 다른 곳에서 영향을 미치지 않음
final class NetworkBasic {
    
    static let shared = NetworkBasic()
    
    private init() { }
    
    
    
    // 성공 케이스와 실패케이스 만들어주기 - 매개변수에 2가지를 실어서 보내는것 가능
    // 왜 옵셔널인 이유? - 디코딩 유무에 따라 옵셔널로 대응하면 하나는 nil이면 하나는 성공이기 때문
    // 컴플리션으로 여러가지의 매개변수를 받을때 성공, 실패 케이스만 얻으면 되는데, 다른 불필요한 경우의 수 발생
    // => Result 타입 : 성공 , 실패 케이스만 가져옴!         @escaping(Photo?, Error?)
    func request(api: SesacAPI, query: String, completionHandler: @escaping(Result<Photo, SeSacError>) -> Void) { // search Photo
        // queryString은 길이 제한이 있어서 간소한 정보만 받을 수 있음 -> parameters 사용
        // Post : 대량의 데이터를 서버에 추가하는 역할 <- 광범위한 범위 ex) 1000자 HTTPBody: Parameter
        // encoding : 파라미터를 queryString으로 보낼 수 있게 도와줌, default는 .httpBody로 되어 있음
        
        AF.request(api.endPoint, method: api.method, parameters: api.query, encoding: URLEncoding(destination: .queryString),headers: api.header)
            .responseDecodable(of: Photo.self) { response in
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
    // @escaping (PhotoResult?, Error?)
    func random(api: SesacAPI,completionHandler: @escaping (Result<PhotoResult, SeSacError>) -> Void) { // random Photo
        
        // PhotoResult : 구조를 보면 Photo의 구조와 유사함... 하나의 구조체를 추가하지 않고 그저 활용하면 됨
        AF.request(api.endPoint, method: api.method, headers: api.header)
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let data):
                    completionHandler(.success(data))
                case .failure(_):
                    // response.response?에서 만약에 nil이 나오면 500을 리턴 해준다.
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSacError(rawValue: statusCode) else { return }
                    completionHandler(.failure(error)) // 실패에 대해서만 던짐
                }
            }
    }

    // 사진 한장에 대한 자세한 정보를 알고 싶다 detail
    func detailPhoto(api: SesacAPI, id: String, completionHandler: @escaping(Result<PhotoResult, SeSacError>) -> Void) { // detail Photo
        
        AF.request(api.endPoint, method: api.method, headers: api.header)
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let data):
                    completionHandler(.success(data))
                case .failure(_):
                    // response.response?에서 만약에 nil이 나오면 500을 리턴 해준다.
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSacError(rawValue: statusCode) else { return }
                    completionHandler(.failure(error)) // 실패에 대해서만 던짐
                }
            }
    }
}
