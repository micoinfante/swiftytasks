//
//  TasksViewModel.swift
//  SwiftyTasks
//
//  Created by Mico Infante on 8/11/22.
//

import Foundation
import SwiftUI
import Combine

final class TaskViewModel: ObservableObject {

    @Published var tasks = Task.mockedTasks
    @Published var currentWeek: [Date] = []
    @Published var currentDay: Date = Date()
    @Published var filteredTasks: [Task]?

    private var repository: TaskRepositoryProtocol
    private var cancelBag = Set<AnyCancellable>()

    init(repository: TaskRepositoryProtocol = TaskRepository()) {
        self.repository = repository
        fetchCurrentWeek()
        loadTasks()
    }

    private func loadTasks() {
        repository.getTasks()
            .sink { response in
                switch response.result {
                case let .success(tasks):
                    self.tasks = tasks
                    print("Got tasks \(tasks)")
                case let .failure(error):
                    print("error loading data \(error)")
                }
            }
            .store(in: &cancelBag)
    }

    func filterTasks() {
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            let filtered = self.tasks.filter {
                return calendar.isDate($0.date, inSameDayAs: self.currentDay)
            }.sorted { task1, task2 in
                return task2.date < task1.date
            }

            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filtered
                }
            }
        }
    }

    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)

        guard let firstWeekDay = week?.start else { return }

        (1...7).forEach { day in
            if let weekDay = calendar.date(byAdding: .day,
                                           value: day,
                                           to: firstWeekDay) {
                currentWeek.append(weekDay)
            }
        }
    }

    func formattedDate(_ date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

    func isToday(_ date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(currentDay, inSameDayAs: date)
    }

    func isCurrentHour(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())

        return hour == currentHour
    }

}
