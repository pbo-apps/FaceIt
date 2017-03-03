//
//  ViewController.swift
//  FaceIt
//
//  Created by Pete Bounford on 08/02/2017.
//  Copyright © 2017 PBO Apps. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    var expression = FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Frown) {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView, action: #selector(FaceView.changeScale(_:))
            ))
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseHappiness)
            )
            happierSwipeGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.decreaseHappiness)
            )
            sadderSwipeGestureRecognizer.direction = .down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            updateUI()
        }
    }
    
    @IBAction func toggleEyes(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            switch expression.eyes {
            case .Open: expression.eyes = .Closed
            case .Closed: expression.eyes = .Open
            case .Squinting: break
            }
        }
    }
    
    private struct Animation {
        static let shakeAngle = CGFloat(M_PI / 6)
        static let shakeDuration = 0.5
    }
    
    @IBAction func headShake(_ sender: UITapGestureRecognizer) {
        rotateHead(by: [Animation.shakeAngle, Animation.shakeAngle * -2, Animation.shakeAngle])
    }
    
    private func rotateHead(by angles: [CGFloat]) {
        if angles.isEmpty {
            return
        }
        UIView.animate(
            withDuration: Animation.shakeDuration,
            animations: {
                self.faceView.transform = self.faceView.transform.rotated(by: angles.first!)
            },
            completion: { finished in
                if finished {
                    let nextAngles = angles.dropFirst()
                    self.rotateHead(by: Array(nextAngles))
                }
            }
        )
    }
    
    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    func decreaseHappiness() {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    private var mouthCurvatures = [FacialExpression.Mouth.Frown:-1.0,.Neutral:0.0,.Smirk:0.2,.Smile:0.5,.Grin:1.0]
    
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed:0.5,.Furrowed:-0.5,.Normal:0.0]
    
    private func updateUI() {
        if faceView != nil {
            switch expression.eyes {
            case .Open: faceView.eyesOpen = true
            case .Closed: faceView.eyesOpen = false
            case .Squinting: faceView.eyesOpen = false
            }
            faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
            faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
        }
    }
    
}

