//
//  ViewModel.swift
//  SeSac3Week10
//
//  Created by 염성필 on 2023/09/20.
//

import Foundation

final class ViewModel {
    
    func request(completionHandler: @escaping (URL) -> Void) {
        Network.shared.requestConvertible(type: PhotoResult.self, api: .random) { response in
            switch response {
            case .success(let success):
                dump(success)
                completionHandler(URL(string: success.urls.thumb)!)
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
    
    
}
