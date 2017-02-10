//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Pete Bounford on 09/02/2017.
//  Copyright © 2017 PBO Apps. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

    private let emotionalFaces: Dictionary<String,FacialExpression> = [
        "angry": FacialExpression(eyes: .Closed, eyeBrows: .Furrowed, mouth: .Frown),
        "happy": FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile),
        "worried": FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
        "mischievous": FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin),
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC = segue.destination
        if let navCon = destinationVC as? UINavigationController {
            destinationVC = navCon.visibleViewController ?? destinationVC
        }
        if let faceVC = destinationVC as? FaceViewController {
            if let identifier = segue.identifier {
                if let expression = emotionalFaces[identifier] {
                    faceVC.expression = expression
                    if let sendingButton = sender as? UIButton {
                        faceVC.navigationItem.title = sendingButton.currentTitle
                    }
                }
            }
        }
        
    }

}
