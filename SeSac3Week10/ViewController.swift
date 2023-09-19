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
       
//        NetworkBasic.shared.random { photo, error in
//            // completionHandler로 받게 되면 옵셔널 바인딩을 해줘야함
//          //  guard let photo = photo else { return }
//            // error가 넘어올때 어떻게 하나요?
//            // photo가 nil이면 return 되서 error 메세지를 받을 수 없음 ⭐️ early exit 되기 때문!!
//          //  guard let error = error else { return }
//
//        }
        
        NetworkBasic.shared.detailPhoto(id: "") { response in
            switch response {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                print(failure)
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



