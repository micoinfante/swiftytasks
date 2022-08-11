//
//  TasksViewModel.swift
//  SwiftyTasks
//
//  Created by Mico Infante on 8/11/22.
//

import Foundation


final class TaskViewModel: ObservableObject {

    @Published var tasks = Task.mockedTasks
    @Published var currentWeek: [Date] = []
    @Published var currentDate: Date = Date()

    init() {
        fetchCurrentWeek()
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

}
