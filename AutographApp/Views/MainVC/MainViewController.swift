//
//  ViewController.swift
//  AutographApp
//
//  Created by David Chester on 7/11/22.
//

import UIKit

class MainVC: UIViewController, UINavigationControllerDelegate, UICollectionViewDelegate, UIImagePickerControllerDelegate {
    let mainView = GalleryView()
    let autographCell = [AutographCell]()

    let signatureView = SignatureScreen()

    var signatureImg: UIImage! {
        didSet {
            imageTaken.image = signatureImg
        }
    }

    // image the user takes
    var imageTaken: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "person.and.arrow.left.and.arrow.right")
        img.backgroundColor = .darkGray
        img.layer.cornerRadius = 20
        return img
    }()

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

    let testViewBttn: UIButton = {
        let tvb = UIButton(type: .system)
        tvb.setTitle("PUSH ME", for: .normal)
        tvb.addTarget(self, action: #selector(testPressed), for: .touchUpInside)
        tvb.translatesAutoresizingMaskIntoConstraints = false
        return tvb
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        title =  "Gallery"
        mainView.autographCollection.delegate = self

        //self.navigationItem.setHidesBackButton(true, animated: false)
    }

    //Push Me Bttn
    @objc func testPressed(){

        signatureView.modalTransitionStyle = .crossDissolve
        signatureView.modalPresentationStyle = .overCurrentContext

        present(signatureView, animated: true)
    }

    @objc func newPhotoPressed(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        picker.delegate = self
        present(picker, animated: true)

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }

       addSignature(putOn: image)




    }

    func addSignature(putOn image: UIImage)  {
        let signatureView = SignatureScreen()
        signatureView.modalTransitionStyle = .crossDissolve
        signatureView.modalPresentationStyle = .overCurrentContext
         present(signatureView, animated: true, completion: {
             signatureView.passedImage = image
        })



    }
}

extension MainVC {

}

extension MainVC {


    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        view.addSubview(testViewBttn)
        view.addSubview(imageTaken)
        view.addSubview(mainView)
        view.addSubview(newPhotoBttn)





        NSLayoutConstraint.activate([

            testViewBttn.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            testViewBttn.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            imageTaken.topAnchor.constraint(equalTo: testViewBttn.bottomAnchor, constant: 50),
            imageTaken.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageTaken.widthAnchor.constraint(equalToConstant: 150),
            imageTaken.heightAnchor.constraint(equalToConstant: 150),

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


