//
//  SearchViewController.swift
//  SeSac3Week10
//
//  Created by 염성필 on 2023/09/21.
//

import UIKit
import SnapKit


class SearchViewController : UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let imageView = UIImageView()
    let label = UILabel()
    let button = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayout()
        configureContentView()
    }
    
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    func configureContentView() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        contentView.addSubview(button)
        
        imageView.backgroundColor = .lightGray
        label.backgroundColor = .green
        button.backgroundColor = .blue
        
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(10)
            make.height.equalTo(200)
        }
        
        button.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(80)
        }
        
        label.numberOfLines = 0
        label.text = "품으며, 낙원을 인간에 돋고, 이는 자신과 아니다. 청춘이 역사를 청춘의 그러므로 위하여서. 되는 모래뿐일 심장은 그러므로 피다. 내는 힘차게 그들을 아니다. 능히 얼음 과실이 소리다.이것은 이상은 싹이 찾아다녀도, 가장 봄바람이다. 투명하되 것은 날카로우나 피고 그것을 없으면, 어디 있으랴? 꽃이 공자는 주며, 소담스러운 이상, 보라. 살 같이, 것이 구하지 쓸쓸한 우리 이상을 있는가? 가는 되려니와, 어디 끝까지 착목한는 그들은 위하여 곧 이성은 이것이다. 인류의 찬미를 속에 이성은 꽃 그와 곳이 품에 교향악이다. 하여도 사랑의 따뜻한 반짝이는 이것이야말로 곳이 찬미를 새 그러므로 것이다.없으면, 대고, 새 방황하였으며, 않는 때문이다. 예수는 같이 피가 되려니와, 역사를 것이다. 피어나기 뭇 끝에 위하여서 있는 보라. 석가는 넣는 봄날의 인간은 있는 이것은 말이다. 대중을 무엇을 우리 열락의 남는 발휘하기 천자만홍이 봄바람이다. 되려니와, 위하여서 인생을 붙잡아 피가 눈에 가는 아니다. 피가 찾아다녀도, 인류의 같이 타오르고 그러므로 풍부하게 이것을 두손을 듣는다. 방황하여도, 이는 속에 열매를 이상은 풀밭에 얼마나 너의 같이, 때문이다. 그들은 이상 어디 튼튼하며, 미묘한 불어 보이는 말이다.고행을 하여도 꽃이 싶이 석가는 것이다. 거선의 맺어, 이것은 많이 싶이 크고 부패뿐이다. 수 찾아 뛰노는 이상의 만물은 이것이다. 바이며, 보배를 물방아 그들에게 없으면, 있으며, 보라. 장식하는 인생에 이것을 있는 우리 군영과 오아이스도 지혜는 있다. 피에 그들은 아니더면, 뿐이다. 무엇을 보이는 유소년에게서 고행을 교향악이다. 평화스러운 위하여 밥을 얼음에 천고에 하는 고동을 주며, 싸인 아름다우냐? 심장의 영원히 피가 것이다."
        label.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.top.equalTo(imageView.snp.bottom).offset(50)
            make.bottom.equalTo(button.snp.top).offset(-50)
        }
        
    }
    
    func configureLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView.contentLayoutGuide).multipliedBy(1.0)
        }
    }
}




// 스크롤 뷰 -> 스택뷰 -> Label
// 스크롤 뷰 -> UIView( 스택뷰 + Label )
//class SearchViewController: UIViewController {
//
//    let scrollView = UIScrollView()
//    let stackView = UIStackView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureView()
//        configureLayout()
//        configureStackView()
//    }
//
//    func configureView() {
//        view.backgroundColor = .white
//        view.addSubview(scrollView)
//        scrollView.addSubview(stackView)
//    }
//
//    func configureLayout() {
//
//        scrollView.backgroundColor = .lightGray
//        scrollView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
//            make.height.equalTo(70)
//        }
//
//        stackView.spacing = 20
//
//        stackView.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(5)
//            make.height.equalToSuperview()
//        }
//
//    }
//
//    func configureStackView() {
//        let label1 = UILabel()
//        label1.text = "안녕하세요"
//        label1.textColor = .white
//        label1.backgroundColor = .orange
//        stackView.addArrangedSubview(label1)
//
//        let label2 = UILabel()
//        label2.text = "안녕하세요1"
//        label2.textColor = .white
//        label2.backgroundColor = .orange
//        stackView.addArrangedSubview(label2)
//
//        let label3 = UILabel()
//        label3.text = "안녕하xcxzcxcxczc세요2"
//        label3.textColor = .white
//        label3.backgroundColor = .orange
//        stackView.addArrangedSubview(label3)
//
//        let label4 = UILabel()
//        label4.text = "안녕sdasdadasd하세요3"
//        label4.textColor = .white
//        label4.backgroundColor = .orange
//        stackView.addArrangedSubview(label4)
//
//        let label5 = UILabel()
//        label5.text = "안녕하qweqweqewq세요4"
//        label5.textColor = .white
//        label5.backgroundColor = .orange
//        stackView.addArrangedSubview(label5)
//
//    }
//}
//
///*
// 1. 자체 영역 : FrameLayoutGuide
// 2. 컨텐츠 영역 : ContentLayoutGuide
// */
