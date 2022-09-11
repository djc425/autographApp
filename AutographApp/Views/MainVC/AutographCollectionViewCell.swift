//
//  AutographCollectionViewCell.swift
//  AutographApp
//
//  Created by David Chester on 9/9/22.
//

import UIKit

//TODO: As we further customize this we're going to want an imageView to take up the entire frame that will be the picture taken + the autograph drawn, maybe a small date label in the lower corner

// create a viewModel for our CollectionViewCell which will hold the properties to be displayed
struct AutographCollectionCellViewModel {
//    let finalImage: UIImage
//    let date: String

    let name: String
    let backgroundColor: UIColor
}

//TODO: Customize further
class AutographCollectionViewCell: UICollectionViewCell {

    static let identifer = "AutographCollectionViewCell"

    let testLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 20)
        lbl.layer.zPosition = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    let imageView: UIImageView = {
        let imgView = UIImageView()
       // imgView.backgroundColor = .red
        imgView.layer.zPosition = -1
        imgView.image = UIImage(systemName: "photo.artframe")
        imgView.clipsToBounds = true

        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureProperties()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //testLabel.frame = contentView.bounds
    }

    func configureCollectionViewCell(with viewModel: AutographCollectionCellViewModel) {
        contentView.backgroundColor = viewModel.backgroundColor
        testLabel.text = viewModel.name
    }

    func configureProperties(){
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.secondaryLabel.cgColor
        contentView.addSubview(testLabel)
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            testLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            testLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

}
