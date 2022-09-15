//
//  MainViewController.swift
//  AutographApp
//
//  Created by David Chester on 7/11/22.
//

import UIKit

class MainVC: UIViewController, UINavigationControllerDelegate {

    // the view which holds the tableViewGallery
    let collectionViewGallery = GalleryUICollectionView()

    let signatureView = SignatureScreen()

    var cellDelegeate: AutographCollectionViewCellDelegate?

    var coreDataManager = CoreDataManager.shared

    var autographModels: [AutographWithSignature] = []

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
//    let testViewBttn: UIButton = {
//        let tvb = UIButton(type: .system)
//        tvb.setTitle("PUSH ME", for: .normal)
//        tvb.addTarget(self, action: #selector(testViewBttnPressed), for: .touchUpInside)
//        tvb.translatesAutoresizingMaskIntoConstraints = false
//        return tvb
//    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        title =  "Gallery"

        collectionViewGallery.tableViewGallery.delegate = self
        collectionViewGallery.tableViewGallery.dataSource = self
        coreDataManager.delegate = self


        coreDataManager.getAutographs()

        print(autographModels.count)

        //self.navigationItem.setHidesBackButton(true, animated: false)
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
    
}

//MARK: CollectionView methods
extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return autographModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // the viewModel to be displayed will be pulled from our array of tableViewCellViewModels
        let viewModel = autographModels[indexPath.row]

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AutographCollectionViewCell.identifer, for: indexPath) as? AutographCollectionViewCell else {
            fatalError()
        }

        // we configure the properties of the cell based on the viewmodel
        cell.configureCollectionViewCell(with: viewModel)
       // cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }

    //TODO: Having trouble getting the delegate to fire to delete an entry but at least we can have the image be displayed when tapped
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        collectionView.deselectItem(at: indexPath, animated: true)
        print("Item selected \(indexPath.row)")

        let viewModelOfCollectionViewToBeTapped = autographModels[indexPath.row]
        signatureImg = UIImage(data: viewModelOfCollectionViewToBeTapped.image!)

        autographCollectionViewCellDidTapItem(with: viewModelOfCollectionViewToBeTapped)
        }
}

extension MainVC {
    func autographCollectionViewCellDidTapItem(with viewModel: AutographWithSignature) {
        //Placeholder Alert
        let alert = UIAlertController(title: viewModel.date, message: "YEA BOI", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.coreDataManager.deleteAutograph(delete: viewModel)
        }))


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
        addSignature(putOn: image)
    }
}

extension MainVC: CoreDataManagerDelegate {
    func didUpdateUI(coreDataManager: CoreDataManager, autoGraph: AutographWithSignature) {
        DispatchQueue.main.async {
            self.autographModels.append(autoGraph)
            self.collectionViewGallery.tableViewGallery.reloadData()
        }
    }


    func didFailWithError(error: Error) {
        print(error)
    }

     
}


// MARK: Load View Extension w/Constraints
extension MainVC {

    override func loadView() {
        view = UIView()
        view.backgroundColor = .purple.withAlphaComponent(70)
        view.addSubview(imageTaken)
        view.addSubview(collectionViewGallery)
        view.addSubview(newPhotoBttn)

        NSLayoutConstraint.activate([

            imageTaken.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            imageTaken.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageTaken.widthAnchor.constraint(equalToConstant: 150),
            imageTaken.heightAnchor.constraint(equalToConstant: 150),

            collectionViewGallery.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionViewGallery.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            collectionViewGallery.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.9),
            collectionViewGallery.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.3),

            newPhotoBttn.topAnchor.constraint(equalTo: collectionViewGallery.bottomAnchor, constant: 20),
            newPhotoBttn.centerXAnchor.constraint(equalTo: collectionViewGallery.centerXAnchor),
            newPhotoBttn.widthAnchor.constraint(equalTo: collectionViewGallery.widthAnchor, multiplier: 0.4),
            newPhotoBttn.heightAnchor.constraint(equalTo: collectionViewGallery.heightAnchor, multiplier: 0.2)
        ])
    }
}


