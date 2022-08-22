//
//  MainView.swift
//  AutographApp
//
//  Created by David Chester on 7/15/22.
//

import UIKit

class GalleryView: UIView {

    let autographCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let agc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        agc.translatesAutoresizingMaskIntoConstraints = false
      //  agc.backgroundColor = .purple
        agc.showsHorizontalScrollIndicator = true
        agc.isScrollEnabled = true

        return agc

    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black.withAlphaComponent(0.3)
        self.layer.cornerRadius = 20
        self.addSubview(autographCollection)

        NSLayoutConstraint.activate([
            autographCollection.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            autographCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            autographCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            autographCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
}

class AutographCell: UICollectionViewCell {

    static let identifier = "CustomAutographCell"

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
      configure()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(){
        self.backgroundColor = .systemRed

        NSLayoutConstraint.activate([
            self.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            self.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            self.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
        ])
    }
}
