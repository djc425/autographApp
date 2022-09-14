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
    let tableViewGallery = GalleryUICollectionView()

    let signatureView = SignatureScreen()

    var cellDelegeate: AutographCollectionViewCellDelegate?

    var coreData = CoreDataManager()

    //     making a variable to hold an array of TableViewCell models to test with
       // let tableViewCellViewModels: AutographTableCellViewModel
    var collectionViewCellViewModels: [AutographCollectionCellViewModel] = [
        AutographCollectionCellViewModel(with: Autograph(date: "TestDate", image: UIImage(systemName: "photo.circle")!, autograph: UIImage(systemName: "scribble")!)),
        AutographCollectionCellViewModel(with: Autograph(date: "TestDate", image: UIImage(systemName: "photo.fill")!, autograph: UIImage(systemName: "scribble")!)),
        AutographCollectionCellViewModel(with: Autograph(date: "TestDate", image: UIImage(systemName: "photo.fill")!, autograph: UIImage(systemName: "scribble")!))
    ]

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

        tableViewGallery.tableViewGallery.delegate = self
        tableViewGallery.tableViewGallery.dataSource = self


        //self.navigationItem.setHidesBackButton(true, animated: false)
    }

   /* func retreive() {
        let collectionCellArray = coreData.getAutographs()!

        let tableViewArray: AutographTableCellViewModel!
        for collectionCellArray in collectionCellArray {
            tableViewArray.autographTableCellViewModels.append(collectionCellArray)
        }

    } */

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

//MARK: tableView methods
extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCellViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // the viewModel to be displayed will be pulled from our array of tableViewCellViewModels
        let viewModel = collectionViewCellViewModels[indexPath.row]

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AutographCollectionViewCell.identifer, for: indexPath) as? AutographCollectionViewCell else {
            fatalError()
        }

        // we configure the properties of the cell based on the viewmodel
        cell.configureCollectionViewCell(with: viewModel)
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }

    //TODO: Having trouble getting the delegate to fire but at least we can have the image be displayed when tapped
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        collectionView.deselectItem(at: indexPath, animated: true)
        print("Item selected \(indexPath.row)")
        let viewModelOfCollectionViewToBeTapped = collectionViewCellViewModels[indexPath.row]
        signatureImg = viewModelOfCollectionViewToBeTapped.takenImage
        cellDelegeate?.autographCollectionViewCellDidTapItem(with: viewModelOfCollectionViewToBeTapped)
        }
}

extension MainVC: AutographCollectionViewCellDelegate {
    func autographCollectionViewCellDidTapItem(with viewModel: AutographCollectionCellViewModel) {
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
        addSignature(putOn: image)
    }
}


// MARK: Load View Extension w/Constraints
extension MainVC {

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        view.addSubview(imageTaken)
        view.addSubview(tableViewGallery)
        view.addSubview(newPhotoBttn)

        NSLayoutConstraint.activate([

            imageTaken.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
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


