//
//  CafeDetailImageService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 6..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CafeDetailImageService: APIService, RequestService {
    
    static let shareInstance = CafeDetailImageService()
    let URL = url("/category/signiture")
    typealias NetworkData = CafeDetailImageData
    
    func getCafeDetailImage(cafeId: Int, token: String, completion: @escaping ([CafeDetailImage]) -> Void, error: @escaping (Int) -> Void) {
        let imageURL = URL + "/\(cafeId)/image"
        let header: HTTPHeaders = [
            "Authoirzation" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(imageURL, body: nil, header: header) { res in
            switch res {
            case .success(let CafeDetailImageData):
                let data = CafeDetailImageData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
