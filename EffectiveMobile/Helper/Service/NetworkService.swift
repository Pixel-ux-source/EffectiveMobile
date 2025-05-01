//
//  NetworkService.swift
//  EffectiveMobile
//
//  Created by Алексей on 01.05.2025.
//

import UIKit
import Alamofire

final class NetworkService {
    // MARK: – Settings URL
    let urlAPI: String = "https://drive.google.com/uc"
    let param: Parameters = [
        "export":"download",
        "id":"1MXypRbK2CS9fqPhTtPonn580h1sHUs2W"
    ]
    
    // MARK: – GET
    func getData(completion: @escaping (Result<[Todo], Error>) -> Void) {
        AF.request(urlAPI, method: .get, parameters: param)
            .validate()
            .responseDecodable(of: ResponseAPI.self, queue: .global()) { response in
                switch response.result {
                case .success(let data):
                    DispatchQueue.main.async {
                        completion(.success(data.todos))
                    }
                case .failure(let error):
                    print("Error get data: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }    
}
