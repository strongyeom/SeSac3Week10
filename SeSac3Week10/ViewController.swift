//
//  ViewController.swift
//  SeSac3Week10
//
//  Created by 염성필 on 2023/09/19.
//

import UIKit
import Alamofire

// 네트워크 통신 -> 개선 -> 업데이트

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        request(query: "cat")
    }
    
    func request(query: String) {
        let key = "R87kkJUhEVTR_QPQo8pQOj7Q7sgWnUP8gTE8h0yOHB0"
        let url = "https://api.unsplash.com/search/photos"
        
        // Header에 Key를 숨기는 것이 URL String에 바로 넣는것보다 안전함
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(key)"]
        // queryString은 길이 제한이 있어서 간소한 정보만 받을 수 있음
        // Post : 대량의 데이터를 서버에 추가하는 역할 <- 광범위한 범위 ex) 1000자 HTTPBody: Parameter
        // encoding : 파라미터를 queryString으로 보낼 수 있게 도와줌
        let query = ["query": query]
        AF.request(url, method: .get, parameters: query, encoding: URLEncoding(destination: .queryString),headers: headers)
            .responseDecodable(of: Photo.self) { response in
                switch response.result {
                case .success(let data):
                    dump(data)
                case .failure(let error):
                    print(error)
                }
            }
      
    }


}

// Codable : Decodable(외부에 있는 데이터를 우리가 사용할 수 있는 형식으로 변환 ) + Encodable(우리가 가지고 있는 데이터를 변환후 외부로 전달 )
struct Photo: Decodable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable {
    let id: String
    let created_at: String
    let urls: PhtoURL
}

struct PhtoURL :Decodable {
    let full: String
    let thumb: String
}


