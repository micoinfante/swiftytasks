//
//  TaskData.swift
//  SwiftyTasksWidgetExtension
//
//  Created by Mico Infante on 8/14/22.
//

import Foundation
import WidgetKit

struct TaskEntry: TimelineEntry {
    var date: Date
    let title: String
    let description: String
}

extension TaskEntry {
    static var timeline: [TaskEntry] = [
        TaskEntry(date: .init(timeIntervalSince1970: 1640991600), title: "Scrum",
                  description: "Daily dev team sync."),
        TaskEntry(date: .init(timeIntervalSince1970: 1640995200), title: "Code Review",
                  description: "Code review pending API pull requests."),
        TaskEntry(date: .init(timeIntervalSince1970: 1640994200), title: "Coffee",
                  description: "Coffee Break ☕️"),
        TaskEntry(date: .init(timeIntervalSince1970: 1640994200), title: "Create new QA Build",
                  description: "Send new QA build to Testflight.")
    ]
}
