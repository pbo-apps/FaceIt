//
//  ViewController.swift
//  FaceIt
//
//  Created by Pete Bounford on 08/02/2017.
//  Copyright © 2017 PBO Apps. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    var expression = FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile) {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var faceView: FaceView! { didSet { updateUI() } }
    
    private var mouthCurvatures = [FacialExpression.Mouth.Frown:-1.0,.Grin:1.0,.Smile:0.5,.Smirk:0.2,.Neutral:0.0]
    
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed:0.5,.Furrowed:-0.5,.Normal:0.0]
    
    private func updateUI() {
        switch expression.eyes {
        case .Open: faceView.eyesOpen = true
        case .Closed: faceView.eyesOpen = false
        case .Squinting: faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
    }
    
}

