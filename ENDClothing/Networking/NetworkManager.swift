//
//  NetworkManager.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 10/06/2021.
//

import UIKit

enum NetworkError: Error {
    case clientError
    case serverError
    case serializationError
    case parsingError
    case unknownError
}

protocol NetworkManagerProtocol {
    func requestData(url: URL, completion: @escaping(Result<[String: Any], NetworkError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {

    func requestData(url: URL, completion: @escaping(Result<[String: Any], NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.clientError))
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.serverError))
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    completion(.success(json))
                }
            } catch {
                completion(.failure(.serializationError))
            }
        }.resume()
    }
}
