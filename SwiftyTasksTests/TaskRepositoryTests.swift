//
//  TaskRepositoryTests.swift
//  SwiftyTasksTests
//
//  Created by Mico Infante on 8/14/22.
//

import XCTest
import Combine
@testable import SwiftyTasks
@testable import Alamofire

final class TaskRepositoryTests: XCTestCase {

    typealias API = TasksAPI

    private var repo: TaskRepository!
    private var subs = Set<AnyCancellable>()

    override func setUp() {
//        repo = TaskRepository(.mockedSession)
    }
}
