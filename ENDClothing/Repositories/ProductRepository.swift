//
//  ProductRepository.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 12/06/2021.
//

import UIKit

protocol ProductRepositoryProtocol {
    func getProducts(completion: @escaping((Result<[Product], NetworkError>) -> Void))
}

final class ProductRepository: ProductRepositoryProtocol {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getProducts(completion: @escaping((Result<[Product], NetworkError>) -> Void)) {
        guard let url = URL(string: "https://www.endclothing.com/media/catalog/example.json") else { return }
        networkManager.requestData(url: url) { result in
            switch result {
            case .success(let jsonDict):
                guard let json = jsonDict["products"] as? [[String: Any]] else {
                    completion(.failure(.parsingError))
                    return
                }
                
                do {
                    let data = try JSONSerialization.data(withJSONObject: json, options: [])
                    let products = try JSONDecoder().decode([Product].self, from: data)
                    completion(.success(products))
                } catch {
                    completion(.failure(.parsingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
