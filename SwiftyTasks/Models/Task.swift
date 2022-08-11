//
//  Task.swift
//  SwiftyTasks
//
//  Created by Mico Infante on 8/11/22.
//

import Foundation
import SwiftUI

struct Task: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var description: String
    var date: Date
}

extension Task {
    static var mockedTasks: [Task] = [
        Task(title: "Scrum", description: "Daily dev team sync.", date: .init(timeIntervalSince1970: 1640991600)),
        Task(title: "Code Review", description: "Code review pending API pull requests.", date: .init(timeIntervalSince1970: 1640995200)),
        Task(title: "Coffee", description: "Coffee Break ☕️", date: .init(timeIntervalSince1970: 1640994200)),
        Task(title: "Create new QA Build", description: "Send new QA build to Testflight.", date: .init(timeIntervalSince1970: 1640994200)),
        Task(title: "Code", description: "Grab new tickets in ToDo", date: .init(timeIntervalSince1970: 1640998200)),
        Task(title: "Break", description: "Lunch Time", date: .init(timeIntervalSince1970: 1641007200)),
        Task(title: "New Project Kick-Off", description: "Zoom meeting - For New iOS Project named PiedPipper", date: .init(timeIntervalSince1970: 1641008200)),
        Task(title: "Project Setup For PiedPipper", description: "Setup ", date: .init(timeIntervalSince1970: 1641009200)),
        Task(title: "Ticket Creation", description: "Create new iOS tickets in Jira.", date: .init(timeIntervalSince1970: 1641010300))
    ]
}
