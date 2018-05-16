//
//  Question.swift
//  Trivia
//
//  Created by Kiki van Rongen on 14-05-18.
//  Copyright © 2018 Kiki van Rongen. All rights reserved.
//

import Foundation

struct Question: Codable {
    var id: Int
    var answer: String?
    var question: String
    var value: Int?
}
