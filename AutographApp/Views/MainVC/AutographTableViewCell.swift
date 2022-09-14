//
//  AutographTableViewCell.swift
//  AutographApp
//
//  Created by David Chester on 9/9/22.
//

import UIKit

//TODO: Remove the whole thang and just use a collection view
struct AutographTableCellViewModel {
    // we set our TableViewCellModels to be an array of autographCollectionViewCellModel's
    var autographTableCellViewModels: [AutographCollectionCellViewModel]
}

protocol AutographTableViewCellDelegate: AnyObject {
    func autographTableViewCellDidTapItem(with viewModel: AutographCollectionCellViewModel)
}

class AutographTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    static let identifier = "AutographTableViewCell"

    var delegate: AutographTableViewCellDelegate?

    // create an array of CollectionViewCellViewModels
    private var autographCollectionCellViewModels: [AutographCollectionCellViewModel] = []

    // collectionView which we'll be putting into our tableView
    private let autographCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)

        collectionView.register(AutographCollectionViewCell.self, forCellWithReuseIdentifier: AutographCollectionViewCell.identifer)

        return collectionView
    }()


    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(autographCollectionView)

        autographCollectionView.delegate = self
        autographCollectionView.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Layout
    //constrain the collectionView's frame to the bounds of the TableViewCells view
    override func layoutSubviews() {
        super.layoutSubviews()
        autographCollectionView.frame = contentView.bounds
    }

    //MARK: CollectionView Methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return autographCollectionCellViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AutographCollectionViewCell.identifer, for: indexPath) as? AutographCollectionViewCell else {
            fatalError()
        }
        // configure the collectionViewCells with CollectionCellViewModel properties
        cell.configureCollectionViewCell(with: autographCollectionCellViewModels[indexPath.row])

        return cell
    }

    // we pass the array of CollectionViewCellModels from our struct above into the array within this TableViewcell that will then populate it
    func configure(with viewModel: AutographTableCellViewModel) {
        self.autographCollectionCellViewModels = viewModel.autographTableCellViewModels
        //reload the data so the collectionView refreshes and displays
        autographCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = contentView.frame.size.width / 2
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let viewModelOfCollectionViewToBeTapped = autographCollectionCellViewModels[indexPath.row]
        delegate?.autographTableViewCellDidTapItem(with: viewModelOfCollectionViewToBeTapped)
    }

}
