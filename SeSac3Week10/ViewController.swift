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
    
    private lazy var scrollView = {
        let view = UIScrollView()
        view.backgroundColor = .green
        // 줌 최소 스케일 설정 - 축소했을때 최소 보장 크기
        view.minimumZoomScale = 1
        view.maximumZoomScale = 4
        view.delegate = self
        // indicator 설정 off
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private let imageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .orange
        view.contentMode = .scaleAspectFit
        // 이미지에 터치 액션이 있을때 isUserInteractionEnabled 설정해줘야한다.
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        configureView()
        configureLayout()
        configureGesture()
        viewModel.request { url in
            self.imageView.kf.setImage(with: url)
        }
    }
    
    // 제스처 기능 추가
    private func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture))
        // 몇번의 탭을 요구 할 것이냐?
        tap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tap)
    }
    
    @objc private func doubleTapGesture() {
        if scrollView.zoomScale == 1 {
            // zoomScale 셋팅
            scrollView.setZoomScale(2, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    
    
    private func configureView() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }
    
    private func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    

    
}

extension ViewController : UIScrollViewDelegate {
    // 줌 했을때 크기를 누가 채워주는데?
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
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



