//
//  ViewController.swift
//  What To Watch
//
//  Created by Sean Ogden Power on 27/4/18.
//  Copyright © 2018 Sean Ogden Power. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    @IBOutlet var streamSelectionButtons: [UIButton]!
    private var selectedStream: StreamName!
    
    
    //MARK: User Interaction
    @IBAction func WhatToWatchTypeTap(_ sender: UIButton) {
        if let streamName = sender.title(for: .normal) {
            selectedStream = StreamName (rawValue: streamName)
        }else{
            //shouldn't happen but if it does just set selected to Whedon
            selectedStream = .whedon
        }
        performSegue(withIdentifier: "ShowQuestionsSegue", sender: nil)
    }
    
    @IBAction func unwindToIntroScreen(segue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    //MARK: UI Functions
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func updateUI (){
        view.setGradientBackground(colorOne: Colors.darkTurquoise, colorTwo: Colors.darkGrey)
        for btn in streamSelectionButtons{
            btn.backgroundColor = Colors.darkBlue
        }
    }

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowQuestionsSegue"){
            let navControler = segue.destination as! UINavigationController
            let questionController = navControler.topViewController as! QuestionViewController
            
            //pass in the question stream title
            questionController.questionStream = selectedStream
        }
    }
    
   
   
}


