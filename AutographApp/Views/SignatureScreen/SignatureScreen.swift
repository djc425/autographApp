//
//  SignatureScreen.swift
//  AutographApp
//
//  Created by David Chester on 7/21/22.
//

import UIKit



class SignatureScreen: UIViewController {

    // properties of the signature to be drawn
    var lastPoint = CGPoint.zero
    var inkColor = UIColor.black
    var brushWidth: CGFloat = 10
    var opacity: CGFloat = 1.0
    // we'll use this Bool later to tell when we've lifted our finger
    var swiped = false

    var signatureImageView: UIImageView = {
        let siv = UIImageView()
        siv.translatesAutoresizingMaskIntoConstraints = false
        siv.backgroundColor = .white
        return siv
    }()

    var passedImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        let value = UIDeviceOrientation.landscapeLeft.rawValue
//        UIDevice.current.setValue(value, forKey: "orientation")
//    }



    // drawing function
    func drawLine(from: CGPoint, to: CGPoint) {
        UIGraphicsBeginImageContext(signatureImageView.frame.size)
         let context = UIGraphicsGetCurrentContext()!

        signatureImageView.image?.draw(in: signatureImageView.bounds)

        context.move(to: from)
        context.addLine(to: to)

        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(inkColor.cgColor)

        context.strokePath()

        signatureImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        signatureImageView.alpha = opacity
        UIGraphicsEndImageContext()

    }

    func getDate() -> String {
       let currentDate = Date()
        return currentDate.formatted(date: .complete, time: .omitted).description
    }

    func buildAutograph(image: UIImage, autograph: UIImage) -> Autograph {
        let autograph = Autograph(date: getDate(), image: image, autograph: autograph)
        return autograph
    }
}

// MARK: Touch overrides
extension SignatureScreen {
    
    // touches began will record where the user starts signing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        swiped = false
        lastPoint = touch.location(in: signatureImageView)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        swiped = true
        let currentPoint = touch.location(in: signatureImageView)
        drawLine(from: lastPoint, to: currentPoint)

        lastPoint = currentPoint
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLine(from: lastPoint, to: lastPoint)
        }

        guard let finalAutograph = signatureImageView.image else { return }
        dump(buildAutograph(image: passedImage, autograph: finalAutograph))

        // once we're done drawing the signature the view dismisses itself
        self.dismiss(animated: true)
        signatureImageView.image = nil
    }
}

// MARK: Load View Extension
extension SignatureScreen {

    override func loadView() {
        view = UIView()
        view.backgroundColor = .purple.withAlphaComponent(0.2)
        view.addSubview(signatureImageView)

        NSLayoutConstraint.activate([
            signatureImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            signatureImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            signatureImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            signatureImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        ])

    }
}



