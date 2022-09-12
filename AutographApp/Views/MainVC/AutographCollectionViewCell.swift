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
    let takenImage: UIImage
    let autographImage: UIImage
    let date: String
}

//TODO: Customize further
class AutographCollectionViewCell: UICollectionViewCell {

    static let identifer = "AutographCollectionViewCell"

    let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.font = .systemFont(ofSize: 14)
        lbl.layer.zPosition = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    let takenImageView: UIImageView = {
        let imgView = UIImageView()
        //imgView.backgroundColor = .red
        imgView.layer.zPosition = 0
        //imgView.image = UIImage(systemName: "photo.artframe")
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()

    let autographImageView: UIImageView = {
        let imgView = UIImageView()
       // imgView.backgroundColor = .red
        imgView.layer.zPosition = 1
        //imgView.image = UIImage(systemName: "scribble.variable")
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
    }

    func configureCollectionViewCell(with viewModel: AutographCollectionCellViewModel) {
       takenImageView.image = viewModel.takenImage
        dateLabel.text = viewModel.date
        autographImageView.image = viewModel.autographImage
    }

    func configureProperties(){
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.secondaryLabel.cgColor
        contentView.addSubview(autographImageView)
        contentView.addSubview(takenImageView)
        contentView.addSubview(dateLabel)

        NSLayoutConstraint.activate([
            autographImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            autographImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            autographImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            autographImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            autographImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),

            takenImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            takenImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            takenImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            takenImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            takenImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

}
