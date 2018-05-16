//
//  QuestionController.swift
//  Trivia
//
//  Created by Kiki van Rongen on 14-05-18.
//  Copyright © 2018 Kiki van Rongen. All rights reserved.
//

import UIKit

class QuestionController {
    
    static let shared = QuestionController()
    let baseURL = URL(string: "http://jservice.io/api/random?count=20")!


//     obtain questions
    func fetchQuestions(completion: @escaping ([Question]?) -> Void) {

        let task = URLSession.shared.dataTask(with: baseURL)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let questionItems = try? jsonDecoder.decode([Question].self, from: data) {
                completion(questionItems)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

}
