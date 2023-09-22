//
//  Constant.swift
//  SeSac3Week10
//
//  Created by 염성필 on 2023/09/22.
//

import UIKit

enum Constant {
    // font , background 이라면 열거형 안에 열거형 적용 : 범주를 구체화 시켜줌
    enum Text {
        static let title = UIColor(named: "title")!
    }
    
    // 이미지에 대한 대응
    enum Image {
        // withRenderingMode : 원래 이미지가 가지고 있는 컬러 값을 지키도록 설정해줄수 있음
        // ex) 이미지는 하얀색인데, 파랗게 나올때 설정하면 된다.
        // withTintColor : 다른 컬러 값으로 바꿔줌
        static let star = UIImage(systemName: "star")!.withRenderingMode(.alwaysOriginal).withTintColor(Constant.Text.title)
    }
}
