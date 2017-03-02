//
//  BlinkingFaceViewController.swift
//  FaceIt
//
//  Created by Pete Bounford on 02/03/2017.
//  Copyright © 2017 PBO Apps. All rights reserved.
//

import UIKit

class BlinkingFaceViewController: FaceViewController {

    var blinking: Bool = false {
        didSet {
            blink()
        }
    }
    
    private struct BlinkRate {
        static let ClosedDuration = 0.4
        static let OpenDuration = 2.5
    }
    
    // The approach shown in lectures was the startBlink/endBlink approach using the #selector form of scheduledTimer. This blink function
    // is a bit more iOS10, which uses a closure to specify the action at the end of the timer. Note that this allows your function called
    // in the closure to be private, unlike the selectors below. This is because the selector has to be exposed to the obj-c framework, and
    // private functions are not exposed to obj-c
    private func blink() {
        if blinking {
            faceView.eyesOpen = !faceView.eyesOpen
            Timer.scheduledTimer(withTimeInterval: faceView.eyesOpen ? BlinkRate.OpenDuration : BlinkRate.ClosedDuration,
                                 repeats: false) { [weak weakSelf = self] _ in
                weakSelf?.blink()
            }
        }
    }
    
    func startBlink() {
        if blinking {
            faceView.eyesOpen = false
            Timer.scheduledTimer(timeInterval: BlinkRate.ClosedDuration, target: self, selector: #selector(self.endBlink), userInfo: nil, repeats: false)
        }
    }
    
    func endBlink() {
        if blinking {
            faceView.eyesOpen = true
            Timer.scheduledTimer(timeInterval: BlinkRate.OpenDuration, target: self, selector: #selector(self.startBlink), userInfo: nil, repeats: false)
        }
    }
    
    // This code is a little contrived, as really you probably want to allow users of the class to control the blinking via the blinking var
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        blinking = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        blinking = false
    }
    
}
