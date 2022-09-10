//
//  WelcomeInstructionsView.swift
//  AutographApp
//
//  Created by David Chester on 7/14/22.
//

import UIKit

class WelcomeInstructionsView: UIView {

    lazy var titleLabel: UILabel = {
        let lbl = UILabel.welcomeLabel()
      //  lbl.text = "Welcome to Autograph"
        return lbl
    }()

    lazy var instructionsLabel: UILabel = {
        let lbl = UILabel.welcomeLabel()
        lbl.text = "Ever meet a celebrity and had no pen on hand? Problem Solved, simply take a photo, have them sign your phone, and save their signature on that photo"
        lbl.numberOfLines = 5
        return lbl
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(){

        addSubview(titleLabel)
        addSubview(instructionsLabel)

        self.backgroundColor = .white.withAlphaComponent(0.3)
        self.layer.cornerRadius = 20
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            instructionsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            instructionsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            instructionsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
}

extension UILabel {

    class func welcomeLabel() -> UILabel {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Welcome to Autograph"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.shadowColor = UIColor.black
        lbl.layer.shadowRadius = 2.0
        lbl.layer.shadowOpacity = 0.1
        lbl.layer.masksToBounds = false
        lbl.layer.shadowOffset = CGSize(width: 0, height: 2)
        return lbl
    }
}

