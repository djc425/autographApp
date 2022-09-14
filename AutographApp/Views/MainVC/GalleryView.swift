//
//  MainView.swift
//  AutographApp
//
//  Created by David Chester on 7/15/22.
//

import UIKit

class GalleryUICollectionView: UIView {

    var tableViewGallery: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)


        layout.collectionView?.isScrollEnabled = true
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)

        collectionView.allowsSelection = true

        
        collectionView.register(AutographCollectionViewCell.self, forCellWithReuseIdentifier: AutographCollectionViewCell.identifer)

        return collectionView
    }()


    override func layoutSubviews() {
        tableViewGallery.frame = self.bounds
    }

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
        self.addSubview(tableViewGallery)
    }
}

