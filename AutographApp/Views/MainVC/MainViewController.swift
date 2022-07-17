//
//  ViewController.swift
//  AutographApp
//
//  Created by David Chester on 7/11/22.
//

import UIKit

class MainVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate {
    let mainView = GalleryView()
    let autographs = [AutographCell]()


    let newPhotoBttn: UIButton = {
        let npb = UIButton(type: .system)
        npb.setTitle("New Photo", for: .normal)
        npb.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        npb.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        npb.tintColor = .darkGray
        npb.backgroundColor = .black.withAlphaComponent(0.2)
        npb.layer.cornerRadius = 20
        npb.addTarget(self, action: #selector(newPhotoPressed), for: .touchUpInside)
        npb.translatesAutoresizingMaskIntoConstraints = false
        return npb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title =  "Gallery"
        mainView.autographCollection.delegate = self
        //self.navigationItem.setHidesBackButton(true, animated: false)
    }

    @objc func newPhotoPressed(){
        let imgPicker = UIImagePickerController()
        imgPicker.allowsEditing = true
        imgPicker.delegate = self
       // imgPicker.sourceType = .camera
        imgPicker.sourceType = .photoLibrary
        present(imgPicker, animated: true)
        /* {
            print("PICKED")
        } */
    }


}

extension MainVC {

}


extension MainVC {

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        view.addSubview(mainView)
        view.addSubview(newPhotoBttn)

        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            mainView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.9),
            mainView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.3),

            newPhotoBttn.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 20),
            newPhotoBttn.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            newPhotoBttn.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.4),
            newPhotoBttn.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.2)
        ])
    }
}
