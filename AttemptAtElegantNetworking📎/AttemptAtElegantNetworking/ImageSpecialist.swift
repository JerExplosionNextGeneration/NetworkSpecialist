//
//  ImageSpecialist.swift
//  AttemptAtElegantNetworking
//
//  Created by Jerry Ren on 12/15/20.
//

import UIKit
import Combine

extension UIImageView {
    // 瞎子摸鱼
    func imageLoadingCombineWay(targetUrl: URL) -> AnyPublisher<UIImage?, Never> {
        return URLSession.shared.dataTaskPublisher(for: targetUrl)
            .map { (data, _) -> UIImage? in return UIImage(data: data) }
            .catch { ero in return Just(nil) }
        .subscribe(on: DispatchQueue.global()) //background queue
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

 









