//
//  EyeView.swift
//  FaceIt
//
//  Created by Pete Bounford on 02/03/2017.
//  Copyright © 2017 PBO Apps. All rights reserved.
//

import UIKit

class EyeView: UIView {

    private struct AnimationConstants {
        static let blink = 0.2
    }
    
    var lineWidth: CGFloat = 5.0 { didSet { setNeedsDisplay() } }
    var color: UIColor = UIColor.blue { didSet { setNeedsDisplay() } }
    // _ here is a convention meaning that _varName is the storage for a computed var varName
    var _eyesOpen: Bool = true { didSet { setNeedsDisplay() } }
    
    var eyesOpen: Bool {
        get {
            return _eyesOpen
        }
        set {
            UIView.transition(
                with: self,
                duration: AnimationConstants.blink,
                options: [.transitionFlipFromTop, .curveEaseInOut],
                animations: {
                    self._eyesOpen = newValue
                },
                completion: nil
            )
        }
    }
    
    override func draw(_ rect: CGRect) {
        var path: UIBezierPath!
        if eyesOpen {
            path = UIBezierPath(ovalIn: bounds.insetBy(dx: lineWidth/2, dy: lineWidth/2))
        } else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.minX, y: bounds.midY))
            path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
        }
        path.lineWidth = lineWidth
        color.setStroke()
        path.stroke()
    }

}
