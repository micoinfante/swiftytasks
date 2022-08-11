//
//  TasksViewModel.swift
//  SwiftyTasks
//
//  Created by Mico Infante on 8/11/22.
//

import Foundation

final class TaskViewModel: ObservableObject {
    @Published var tasks = Task.mockedTasks
}
