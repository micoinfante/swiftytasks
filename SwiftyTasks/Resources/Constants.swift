//
//  Constants.swift
//  SwiftyTasks
//
//  Created by Mico Infante on 8/12/22.
//

import Foundation

struct Constants {
    struct Key {
        static var currentDay = "CURRENT_DAY"
    }

    static var baseURL: URL {
        return URL(string: "https://62ecc6df55d2bd170e868662.mockapi.io/api/v1/")!
    }
}
