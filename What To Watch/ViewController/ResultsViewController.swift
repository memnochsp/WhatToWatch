//
//  ResultsViewController.swift
//  What To Watch
//
//  Created by Sean Ogden Power on 27/4/18.
//  Copyright © 2018 Sean Ogden Power. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var topResultsFrame: UIView!
    @IBOutlet weak var topResultsImage: UIImageView!
    @IBOutlet weak var topResultsTitle: UILabel!
    @IBOutlet weak var topResultsDescription: UILabel!
    @IBOutlet weak var topResultsPercentage: UILabel!
    @IBOutlet weak var secondResultsFrame: UIView!
    @IBOutlet weak var secondResultsImage: UIImageView!
    @IBOutlet weak var secondResultsTitle: UILabel!
    @IBOutlet weak var secondResultsPercent: UILabel!
    @IBOutlet weak var thirdResultsFrame: UIView!
    @IBOutlet weak var thirdResultsImage: UIImageView!
    @IBOutlet weak var thirdResultsTitle: UILabel!
    @IBOutlet weak var thirdResultsPercent: UILabel!
    
    var results : [(key: Double, value: Recomendation)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.setGradientBackground(colorOne: Colors.darkTurquoise, colorTwo: Colors.darkGrey)
        topResultsFrame.setCardFrame()
        secondResultsFrame.setCardFrame()
        thirdResultsFrame.setCardFrame()
        
        topResultsImage.roundCorners()
        secondResultsImage.roundCorners()
        thirdResultsImage.roundCorners()
        
        updateUI()
    }
    
    //MARK: UI Functions
    func updateUI (){
        //hide the second two results incase they're not returned.
        secondResultsFrame.isHidden = true
        thirdResultsFrame.isHidden = true

        var resNumber = 1
        for res in results {
            
            let val = res.value
            switch resNumber{
            case 1:
                topResultsPercentage.text = "\(String(format: "%.2f%", res.key))% Match"
                topResultsTitle.text = val.rawValue
                topResultsImage.image = UIImage (named: val.image)
                topResultsDescription.text = val.definition
                break
            case 2:
                secondResultsPercent.text = "\(String(format: "%.2f%", res.key))%"
                secondResultsTitle.text = val.rawValue
                secondResultsImage.image = UIImage (named: "\(val.image)square")
                secondResultsFrame.isHidden = false
                break
            case 3:
                thirdResultsPercent.text = "\(String(format: "%.2f%", res.key))%"
                thirdResultsTitle.text = val.rawValue
                thirdResultsImage.image = UIImage (named: "\(val.image)square")
                thirdResultsFrame.isHidden = false
                break
            default:
                break
            }
            resNumber += 1
        }
        
    }
    
    private func setNavBarTranslucent (){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    

}
