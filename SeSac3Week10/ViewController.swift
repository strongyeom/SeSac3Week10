//
//  ViewController.swift
//  SeSac3Week10
//
//  Created by 염성필 on 2023/09/19.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    
    private let imageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .orange
        view.contentMode = .scaleToFill
        return view
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        configureView()
        configureLayout()
        
        request()
    }
        
        func configureLayout() {
            imageView.snp.makeConstraints { make in
                make.size.equalTo(200)
                make.center.equalToSuperview()
            }
        }
        
        func configureView() {
            view.addSubview(imageView)
        }
        
        fileprivate func request() {
            Network.shared.requestConvertible(type: PhotoResult.self, api: .random) { response in
                switch response {
                case .success(let success):
                    dump(success)
                    
                    // 응답 한 url 기반으로 이미지 뷰에 사진 띄우기
                    self.imageView.kf.setImage(with: URL(string: success.urls.thumb)!)
                case .failure(let failure):
                    print(failure.errorDescription)
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



