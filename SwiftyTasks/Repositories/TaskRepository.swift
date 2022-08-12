//
//  TaskRepository.swift
//  SwiftyTasks
//
//  Created by Mico Infante on 8/12/22.
//

import Foundation
import Alamofire
import Combine

protocol TaskRepositoryProtocol {
    func getTasks() -> AnyPublisher<DataResponse<[Task], AFError>, Never>
}

final class TaskRepository: TaskRepositoryProtocol {
    private var networkService: NetworkServiceProtocol!
    private var cancelBag: [AnyCancellable] = []

    init(networkService: NetworkServiceProtocol = NetworkService.default) {
        self.networkService =  networkService
    }

    func getTasks() -> AnyPublisher<DataResponse<[Task], AFError>, Never> {
        return networkService.execute(TasksAPI.getTasks, model: [Task].self)
    }
}

enum TasksAPI: URLRequestBuilder {
    case getTasks
}

extension TasksAPI {
    var path: String {
        switch self {
        case .getTasks:
            return "tasks"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .getTasks:
            return nil
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getTasks: return HTTPMethod.get
        }
    }
}
