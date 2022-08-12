//
//  NetworkService.swift
//  SwiftyTasks
//
//  Created by Mico Infante on 8/12/22.
//

import Alamofire
import Combine

protocol NetworkServiceProtocol: AnyObject {
    func execute<T: Codable>(_ urlRequest: URLRequestBuilder,
                             model: T.Type,
                             completion: @escaping (Result<T, AFError>) -> Void
    ) -> AnyCancellable

    func execute<T: Codable>(_ urlRequest: URLRequestBuilder,
                             model: T.Type
    ) -> AnyPublisher<DataResponse<T, AFError>, Never>
}

extension NetworkServiceProtocol {
    func execute<T: Codable>(_ urlRequest: URLRequestBuilder,
                             model: T.Type,
                             completion: @escaping (Result<T, AFError>) -> Void
    ) -> AnyCancellable {
        let requestPublisher = AF.request(urlRequest).publishDecodable(type: T.self)

        let cancellable = requestPublisher
            .subscribe(on: DispatchQueue(label: "Background Queue", qos: .background))
            .receive(on: RunLoop.main)
            .sink { result in
                if let value = result.value {
                    completion(Result.success(value))
                } else if let error = result.error {
                    completion(Result.failure(error))
                }
            }
        return cancellable
    }

    func execute<T: Codable>(_ urlRequest: URLRequestBuilder,
                             model: T.Type
    ) -> AnyPublisher<DataResponse<T, AFError>, Never> {
        let requestPublisher = AF.request(urlRequest).publishDecodable(type: T.self, decoder: jsonDecoder())

        let cancellable = requestPublisher
            .subscribe(on: DispatchQueue(label: "Background Queue", qos: .background))
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()

        return cancellable
    }

    private func jsonDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
}

final class NetworkService: NetworkServiceProtocol {
    static let `default`: NetworkServiceProtocol = {
        var service = NetworkService()
        return service
    }()
}
