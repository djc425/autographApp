//
//  MainViewController.swift
//  AutographApp
//
//  Created by David Chester on 7/11/22.
//

import UIKit

//TODO: to begin with lets just automatically apply the signature to the bottom of the photo, in a future version we'll let users move it around. But right now once the signautre is done it'll be attached to the lower part of the photo.
// - Look at image picker to put a method in there
// - look at addSignature method to combine images and then add the date as a string

class MainVC: UIViewController, UINavigationControllerDelegate {

    // the view which holds the tableViewGallery
    let tableViewGallery = GalleryViewTableView()

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

    //MARK: Buttons set up
    let newPhotoBttn: UIButton = {
        let npb = UIButton(type: .system)
        npb.setTitle("New Photo", for: .normal)
        npb.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        npb.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        npb.tintColor = .darkGray
        npb.backgroundColor = .black.withAlphaComponent(0.2)
        npb.layer.cornerRadius = 20
        npb.addTarget(self, action: #selector(newPhotoBttnPressed), for: .touchUpInside)
        npb.translatesAutoresizingMaskIntoConstraints = false
        return npb
    }()

    //TODO: Remove once testing with phyiscal device
    let testViewBttn: UIButton = {
        let tvb = UIButton(type: .system)
        tvb.setTitle("PUSH ME", for: .normal)
        tvb.addTarget(self, action: #selector(testViewBttnPressed), for: .touchUpInside)
        tvb.translatesAutoresizingMaskIntoConstraints = false
        return tvb
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        title =  "Gallery"

        tableViewGallery.tableViewGallery.delegate = self
        tableViewGallery.tableViewGallery.dataSource = self
        tableViewGallery.tableViewGallery.register(AutographTableViewCell.self, forCellReuseIdentifier: AutographTableViewCell.identifier)

        //self.navigationItem.setHidesBackButton(true, animated: false)
    }

    //Push Me Bttn
    @objc func testViewBttnPressed(){
        signatureView.modalTransitionStyle = .crossDissolve
        signatureView.modalPresentationStyle = .overCurrentContext

        present(signatureView, animated: true)
    }

    @objc func newPhotoBttnPressed(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        picker.delegate = self
        present(picker, animated: true)
    }

    func addSignature(putOn image: UIImage)  {
        signatureView.modalTransitionStyle = .crossDissolve
        signatureView.modalPresentationStyle = .overCurrentContext
         present(signatureView, animated: true, completion: {
             self.signatureView.passedImage = image
        })
    }

//     making a variable to hold an array of TableViewCell models to test with
    private let tableViewCellViewModels: [AutographTableCellViewModel] = [
        AutographTableCellViewModel(autographTableCellViewModels: [
            AutographCollectionCellViewModel(takenImage: UIImage(systemName: "photo.fill")!, autographImage: UIImage(systemName: "scribble.variable")!, date: "DATE TEST"),
            AutographCollectionCellViewModel(takenImage: UIImage(systemName: "photo.fill")!, autographImage: UIImage(systemName: "scribble.variable")!, date: "9/12/2022"),
            AutographCollectionCellViewModel(takenImage: UIImage(systemName: "photo.fill")!, autographImage: UIImage(systemName: "scribble.variable")!, date: "9/13/2022"),
        ])
    ]
    
}

//MARK: tableView methods
 extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // the viewModel to be displayed will be pulled from our array of tableViewCellViewModels
       let viewModel = tableViewCellViewModels[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AutographTableViewCell.identifier, for: indexPath) as? AutographTableViewCell else {
            fatalError()
        }

        // we configure the properties of the cell based on the viewmodel
        cell.configure(with: viewModel)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewGallery.tableViewGallery.frame.size.height 
    }


}

extension MainVC: AutographTableViewCellDelegate {
    func autographTableViewCellDidTapItem(with viewModel: AutographCollectionCellViewModel) {
        //Placeholder Alert
        let alert = UIAlertController(title: viewModel.date, message: "YEA BOI", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        present(alert, animated: true)
    }
}

// MARK: image picker methods
extension MainVC: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    // TODO: Here we want to capture the chosen image and save it to our ViewModel
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        self.imageTaken.image = image
      // addSignature(putOn: image)
    }
}


// MARK: Load View Extension w/Constraints
extension MainVC {

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        view.addSubview(testViewBttn)
        view.addSubview(imageTaken)

        view.addSubview(tableViewGallery)

        view.addSubview(newPhotoBttn)

        NSLayoutConstraint.activate([

            testViewBttn.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            testViewBttn.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            imageTaken.topAnchor.constraint(equalTo: testViewBttn.bottomAnchor, constant: 50),
            imageTaken.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageTaken.widthAnchor.constraint(equalToConstant: 150),
            imageTaken.heightAnchor.constraint(equalToConstant: 150),

            tableViewGallery.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableViewGallery.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            tableViewGallery.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.9),
            tableViewGallery.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.3),

            newPhotoBttn.topAnchor.constraint(equalTo: tableViewGallery.bottomAnchor, constant: 20),
            newPhotoBttn.centerXAnchor.constraint(equalTo: tableViewGallery.centerXAnchor),
            newPhotoBttn.widthAnchor.constraint(equalTo: tableViewGallery.widthAnchor, multiplier: 0.4),
            newPhotoBttn.heightAnchor.constraint(equalTo: tableViewGallery.heightAnchor, multiplier: 0.2)
        ])
    }
}


