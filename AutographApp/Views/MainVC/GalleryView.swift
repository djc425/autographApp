//
//  MainView.swift
//  AutographApp
//
//  Created by David Chester on 7/15/22.
//

import UIKit

class GalleryView: UIView {

//    let scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.alwaysBounceHorizontal = true
//        scrollView.backgroundColor = .cyan
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        return scrollView
//    }()
//
//    let stackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.distribution = .fillEqually
//        stackView.spacing = 30
//        stackView.backgroundColor = .red
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()

    let autographCollection: UICollectionView = {
        let layout = UICollectionViewLayout()
        let agc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        agc.translatesAutoresizingMaskIntoConstraints = false
        agc.backgroundColor = .purple
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
        //scrollView.addSubview(stackView)


        NSLayoutConstraint.activate([

//            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//
//            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
//            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
//            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),

            autographCollection.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            autographCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            autographCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            autographCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
}

class AutographCell: UICollectionViewCell {


}
