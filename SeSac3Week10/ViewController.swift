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
        // Do any additional setup after loading the view.
    }
    
    func request() {
        let key = "R87kkJUhEVTR_QPQo8pQOj7Q7sgWnUP8gTE8h0yOHB0"
        let url = "https://api.unsplash.com/search/photos?query=cat&client_id=\(key)"
        
        AF.request(url, method: .get)
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


