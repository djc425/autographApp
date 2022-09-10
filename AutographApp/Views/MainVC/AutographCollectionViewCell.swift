//
//  AutographCollectionViewCell.swift
//  AutographApp
//
//  Created by David Chester on 9/9/22.
//

import UIKit

// create a viewModel for our CollectionViewCell which will hold the properties to be displayed
struct AutographCollectionCellViewModel {
    let name: String
    let backgroundColor: UIColor
}

//TODO: Customize further
class AutographCollectionViewCell: UICollectionViewCell {

    static let identifer = "AutographCollectionViewCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCollectionViewCell(with viewModel: AutographCollectionCellViewModel) {
        contentView.backgroundColor = viewModel.backgroundColor
    }

}
