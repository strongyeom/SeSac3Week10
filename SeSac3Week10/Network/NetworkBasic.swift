//
//  NetworkBasic.swift
//  SeSac3Week10
//
//  Created by 염성필 on 2023/09/19.
//

import Foundation
import Alamofire

// final : 암묵적으로 상속이 안되고 재정의도 안되서 다른 곳에서 영향을 미치지 않음
final class NetworkBasic {
    
    static let shared = NetworkBasic()
    
    private init() { }
    
    
    
    // 성공 케이스와 실패케이스 만들어주기 - 매개변수에 2가지를 실어서 보내는것 가능
    // 왜 옵셔널인 이유? - 디코딩 유무에 따라 옵셔널로 대응하면 하나는 nil이면 하나는 성공이기 때문
    // 컴플리션으로 여러가지의 매개변수를 받을때 성공, 실패 케이스만 얻으면 되는데, 다른 불필요한 경우의 수 발생
    // => Result 타입 : 성공 , 실패 케이스만 가져옴!        @escaping(Photo?, Error?)
    func request(query: String, completion: @escaping(Result<Photo, Error>) -> Void) { // search Photo
        let key = "R87kkJUhEVTR_QPQo8pQOj7Q7sgWnUP8gTE8h0yOHB0"
        let url = "https://api.unsplash.com/search/photos"
        
        // Header에 Key를 숨기는 것이 URL String에 바로 넣는것보다 안전함
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(key)"]
        // queryString은 길이 제한이 있어서 간소한 정보만 받을 수 있음 -> parameters 사용
        // Post : 대량의 데이터를 서버에 추가하는 역할 <- 광범위한 범위 ex) 1000자 HTTPBody: Parameter
        // encoding : 파라미터를 queryString으로 보낼 수 있게 도와줌, default는 .httpBody로 되어 있음
        let query = ["query": query] // <- 명시적으로 구분
        AF.request(url, method: .get, parameters: query, encoding: URLEncoding(destination: .queryString),headers: headers)
            .responseDecodable(of: Photo.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data)) // 성공에 대한 데이터만 던짐
                case .failure(let error):
                    completion(.failure(error)) // 실패에 대해서만 던짐
                }
            }
    }
    
    func random(completionHandler: @escaping(PhotoResult?, Error?) -> Void) { // random Photo
        let key = "R87kkJUhEVTR_QPQo8pQOj7Q7sgWnUP8gTE8h0yOHB0"
        let url = "https://api.unsplash.com/photos/random"
        
        // Header에 Key를 숨기는 것이 URL String에 바로 넣는것보다 안전함
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(key)"]
        
        // PhotoResult : 구조를 보면 Photo의 구조와 유사함... 하나의 구조체를 추가하지 않고 그저 활용하면 됨
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let data):
                    completionHandler(data, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
            }
    }

    // 사진 한장에 대한 자세한 정보를 알고 싶다 detail  aBAljYASvrg
    func detailPhoto(id: String, completionHandler: @escaping(Result<PhotoResult, Error>) -> Void) { // detail Photo
        let key = "R87kkJUhEVTR_QPQo8pQOj7Q7sgWnUP8gTE8h0yOHB0"
        let url = "https://api.unsplash.com/photos/\(id)"
        
        // Header에 Key를 숨기는 것이 URL String에 바로 넣는것보다 안전함
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(key)"]
        
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let data):
                    completionHandler(.success(data))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
}
