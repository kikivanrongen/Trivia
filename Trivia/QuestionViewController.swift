//
//  QuestionViewController.swift
//  Trivia
//
//  Created by Kiki van Rongen on 14-05-18.
//  Copyright © 2018 Kiki van Rongen. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    // MARK: Outlets & Actions
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    // submit answer and redirect to new question
    @IBAction func submitAnswerButtonTapped(_ sender: UIButton) {
        
        updateScore(with: questionItems)
        nextQuestion()
    }
    
    
    // Receive questions from API
    
    // Constants and Variables
    var questionIndex = 0
    var questionNumber = 1
    let questionMax = 10
    var questionItems = [Question]()
    
    var score = 0
    
    // MARK: Functions
    
    // go to next question
    func nextQuestion() {
        questionNumber += 1
        questionIndex += 1
        if questionNumber <= questionMax {
            updateUI()
        } else {
            performSegue(withIdentifier: "ScoreSegue", sender: nil)
        }
        
        // empty text field
        answerTextField.text = ""
    }
    
    // update navigation title, progress view
    func updateUI() {
        
        QuestionController.shared.fetchQuestions() { (questionItems) in
            if let questionItems = questionItems {
                DispatchQueue.main.async {
                    while questionItems[self.questionIndex].answer?.isEmpty == true || questionItems[self.questionIndex].value == nil {
                        self.questionIndex += 1
                    }
                    self.questionLabel.text = questionItems[self.questionIndex].question
                    self.questionItems = questionItems
                }
            }
        }
        
        navigationItem.title = "Question #\(questionNumber)"
        
        let totalProgress = Float(questionNumber - 1) / Float(questionMax)
        questionProgressView.setProgress(totalProgress, animated: true)
        
    }
    
    // check for correct answer and update score
    func updateScore(with questionItems: [Question]) {
        
        if answerTextField.text?.lowercased() == questionItems[questionIndex].answer?.lowercased() {
            score += questionItems[questionIndex].value!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // pass on score to score view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ScoreSegue" {
            let scoreViewController = segue.destination as! ScoreViewController
            scoreViewController.response = score
        }
    }
    
}
