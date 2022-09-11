//
//  WelcomeVC.swift
//  AutographApp
//
//  Created by David Chester on 7/14/22.
//

import UIKit

//View Controller that welcomes the user and displays the instructions
//TODO: Swipe through instructions

class WelcomeVC: UIViewController {

    let welcomeView = WelcomeInstructionsView()
    
    let nextButton: UIButton = {
        let nb = UIButton(type: .custom)
        nb.setTitle("Next", for: .normal)
        nb.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nb.backgroundColor = .black
        nb.tintColor = .white
        nb.layer.cornerRadius = 20
        nb.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        nb.translatesAutoresizingMaskIntoConstraints = false
        return nb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc func nextButtonPressed(){
        navigationController?.pushViewController(MainVC(), animated: true)
        print("NextButtonPressed")
    }
}

//MARK: LoadView Extenstion and Constraints
extension WelcomeVC {
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(red: 200/255, green: 182/255, blue: 226/255, alpha: 1)

        view.addSubview(welcomeView)
        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            welcomeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            welcomeView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            welcomeView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),

            nextButton.topAnchor.constraint(equalTo: welcomeView.bottomAnchor, constant: 20),
            nextButton.widthAnchor.constraint(equalTo: welcomeView.widthAnchor, multiplier: 0.8),
            nextButton.heightAnchor.constraint(equalTo: welcomeView.heightAnchor, multiplier: 0.15),
            nextButton.centerXAnchor.constraint(equalTo: welcomeView.centerXAnchor),
        ])
    }
}
