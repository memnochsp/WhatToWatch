//
//  QuestionViewController.swift
//  What To Watch
//
//  Created by Sean Ogden Power on 27/4/18.
//  Copyright © 2018 Sean Ogden Power. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var questionProgress: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    
    //MARK: Multi Answer Outlets
    @IBOutlet weak var multiAnswerLayout: UIStackView!
    @IBOutlet weak var multiAnswerLabel1: UILabel!
    @IBOutlet weak var multiAnswerLabel2: UILabel!
    @IBOutlet weak var multiAnswerLabel3: UILabel!
    @IBOutlet weak var multiAnswerLabel4: UILabel!
    @IBOutlet weak var multiAnswerLabel5: UILabel!
    @IBOutlet weak var multiAnswer1: UISwitch!
    @IBOutlet weak var multiAnswer2: UISwitch!
    @IBOutlet weak var multiAnswer3: UISwitch!
    @IBOutlet weak var multiAnswer4: UISwitch!
    @IBOutlet weak var multiAnswer5: UISwitch!
    @IBOutlet weak var mutliAnswerSubmitButton: UIButton!
    
    //MARK: Single Answer Outlets
    @IBOutlet weak var singleAnswerLayout: UIStackView!
    @IBOutlet var singleAnswerButtons: [UIButton]!
    
    //MARK: Slider Answer Outlets
    @IBOutlet weak var sliderAnswerLayout: UIStackView!
    @IBOutlet weak var sliderAnswer: UISlider!
    @IBOutlet weak var sliderLabel1: UILabel!
    @IBOutlet weak var sliderLabel2: UILabel!
    @IBOutlet weak var sliderAnswerButton: UIButton!
    
    //MARK: User interaction
    @IBAction func multiAnswerSubmitTouch(_ sender: UIButton) {
        if multiAnswer1.isOn {
            questionEngine.responses.append(currentResponses[0])
        }
        if multiAnswer2.isOn {
            questionEngine.responses.append(currentResponses[1])
        }
        if multiAnswer3.isOn {
            questionEngine.responses.append(currentResponses[2])
        }
        if multiAnswer4.isOn {
            questionEngine.responses.append(currentResponses[3])
        }
        if multiAnswer5.isOn {
            questionEngine.responses.append(currentResponses[4])
        }
        
        nextQuestion()
    }
    
    @IBAction func singleAnswerButtonTouch(_ sender: UIButton) {
        switch sender{
        case singleAnswerButtons[0]:
            questionEngine.responses.append(currentResponses[0])
        case singleAnswerButtons[1]:
            questionEngine.responses.append(currentResponses[1])
        case singleAnswerButtons[2]:
           questionEngine.responses.append(currentResponses[2])
        case singleAnswerButtons[3]:
            questionEngine.responses.append(currentResponses[3])
        case singleAnswerButtons[4]:
            questionEngine.responses.append(currentResponses[4])
        default:
            break
        }
        nextQuestion()
        
    }
    
    @IBAction func sliderAnswerSubmitTouch(_ sender: UIButton) {
        let index = Int(round(sliderAnswer.value * Float(currentResponses.count - 1 )))
        questionEngine.responses.append(currentResponses[index])
        
        nextQuestion()
    }
    
    var questionEngine:RecomendationEngine!
    var questionStream:StreamName!
    var currentQuestion:Question!
    var currentResponses:[Response]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.setGradientBackground(colorOne: Colors.darkTurquoise, colorTwo: Colors.darkGrey)
        
        setNavBarTranslucent ()
        setupButtons ()
        cardView.setCardFrame ()
        setupEngine ()
        updateUI()
    }
    
    //MARK: UI Functions
    private func setNavBarTranslucent (){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func setupButtons(){
        mutliAnswerSubmitButton.backgroundColor = Colors.darkBlue
        sliderAnswerButton.backgroundColor = Colors.darkBlue
        for btn in singleAnswerButtons{
            btn.backgroundColor = Colors.darkBlue
        }
    }
    
    func updateUI (){
        navigationItem.title = "Question \(questionEngine.questionIndex) of \(questionEngine.currentQuestions.count)"
        questionProgress.progress = Float(questionEngine.questionIndex) / Float(questionEngine.currentQuestions.count)
        
        questionLabel.text = currentQuestion.text
        
        //Hide all the question stacks
        multiAnswerLayout.isHidden = true
        singleAnswerLayout.isHidden = true
        sliderAnswerLayout.isHidden = true
        
        currentResponses = questionEngine.shuffle(currentQuestion.responses)
        //there might be between 2 and 5 responses so from here check if we have enough responses
        //hide them all first then add show it if its available
        let responseCount = currentResponses.count
        
        switch currentQuestion.type{
        case .single:
            singleAnswerLayout.isHidden = false
            singleAnswerButtons[0].setTitle (currentResponses[0].text, for: .normal)
            singleAnswerButtons[1].setTitle (currentResponses[1].text, for: .normal)
            
            //hide 3-5 turn them on as needed
            singleAnswerButtons[2].isHidden = true
            singleAnswerButtons[3].isHidden = true
            singleAnswerButtons[4].isHidden = true
            
            if responseCount > 2 {
                singleAnswerButtons[2].setTitle (currentResponses[2].text, for: .normal)
                singleAnswerButtons[2].isHidden = false
            }
            if responseCount > 3 {
                singleAnswerButtons[3].setTitle (currentResponses[3].text, for: .normal)
                singleAnswerButtons[3].isHidden = false
            }
            if responseCount > 4 {
                singleAnswerButtons[4].setTitle (currentResponses[4].text, for: .normal)
                singleAnswerButtons[4].isHidden = false
            }

        case .multiple:
            multiAnswerLayout.isHidden = false
            //turn off all the switches
            multiAnswer1.isOn = false
            multiAnswer2.isOn = false
            multiAnswer3.isOn = false
            multiAnswer4.isOn = false
            multiAnswer5.isOn = false
            
            //hide 3-5 turn them on as needed
            multiAnswerLabel3.isHidden = true
            multiAnswer3.isHidden = true
            multiAnswerLabel4.isHidden = true
            multiAnswer4.isHidden = true
            multiAnswerLabel5.isHidden = true
            multiAnswer5.isHidden = true
            
            multiAnswerLabel1.text = currentResponses[0].text
            multiAnswerLabel2.text = currentResponses[1].text
            if responseCount > 2 {
                multiAnswerLabel3.text = currentResponses[2].text
                multiAnswerLabel3.isHidden = false
                multiAnswer3.isHidden = false
            }
            if responseCount > 3 {
                multiAnswerLabel4.text = currentResponses[3].text
                multiAnswerLabel4.isHidden = false
                multiAnswer4.isHidden = false
            }
            if responseCount > 4 {
                multiAnswerLabel5.text = currentResponses[4].text
                multiAnswerLabel5.isHidden = false
                multiAnswer5.isHidden = false
            }
           
        case .slider:
            //NOTE: I dont want the slider's answers randomised, it will screw it up
            currentResponses = currentQuestion.responses
            sliderAnswerLayout.isHidden = false
            sliderLabel1.text = currentResponses.first?.text
            sliderLabel2.text = currentResponses.last?.text
            sliderAnswer.setValue (0.5, animated: false)
        }
        
    }
    
    //MARK: Quiz Logic
    //setup the question engine
    func setupEngine (){
        questionEngine = RecomendationEngine ()
        questionEngine.setupQuiz(for: questionStream)
        currentQuestion = questionEngine.getNextQuestion()
    }
    
    func nextQuestion (){
        if let question = questionEngine.getNextQuestion(){
            currentQuestion = question
            updateUI()
        } else {
            
            performSegue(withIdentifier: "ShowResultsSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowResultsSegue"){
            let resultsController = segue.destination as! ResultsViewController
            resultsController.results = questionEngine.calculateResult()
        }
    }
    
}
