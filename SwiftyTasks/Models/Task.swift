//
//  Task.swift
//  SwiftyTasks
//
//  Created by Mico Infante on 8/11/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let task = try Task(json)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseTask { response in
//     if let task = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - Task
struct Task: Codable, Equatable, Identifiable {
    let id: String
    let title: String
    let description: String
    let date: Date

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case date
    }
}

extension Task {
    static var mockedTasks: [Task] = [
        Task(id: "0", title: "Scrum",
             description: "Daily dev team sync.",
             date: .init(timeIntervalSince1970: 1640991600)),
        Task(id: "1", title: "Code Review",
             description: "Code review pending API pull requests.",
             date: .init(timeIntervalSince1970: 1640995200)),
        Task(id: "2", title: "Coffee",
             description: "Coffee Break ☕️",
             date: .init(timeIntervalSince1970: 1640994200)),
        Task(id: "3", title: "Create new QA Build",
             description: "Send new QA build to Testflight.",
             date: .init(timeIntervalSince1970: 1640994200)),
        Task(id: "4", title: "Code",
             description: "Grab new tickets in ToDo",
             date: .init(timeIntervalSince1970: 1640998200)),
        Task(id: "5", title: "Break", description: "Lunch Time",
             date: .init(timeIntervalSince1970: 1641007200)),
        Task(id: "6", title: "New Project Kick-Off",
             description: "Zoom meeting - For New iOS Project named PiedPipper",
             date: .init(timeIntervalSince1970: 1641008200)),
        Task(id: "7", title: "Project Setup For PiedPipper",
             description: "Setup ",
             date: .init(timeIntervalSince1970: 1641009200)),
        Task(id: "8", title: "Ticket Creation",
             description: "Create new iOS tickets in Jira.",
             date: .init(timeIntervalSince1970: 1641010300))
    ]
}
