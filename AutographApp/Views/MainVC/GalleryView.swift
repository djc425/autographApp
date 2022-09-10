//
//  MainView.swift
//  AutographApp
//
//  Created by David Chester on 7/15/22.
//

import UIKit

class GalleryViewTableView: UIView {

    var tableViewGallery: UITableView = {
        let tableViewGallery = UITableView()
        tableViewGallery.translatesAutoresizingMaskIntoConstraints = false
       // register the tableView's cell with an AutographTableViewCell
        tableViewGallery.register(AutographTableViewCell.self, forCellReuseIdentifier: AutographTableViewCell.identifier)

        return tableViewGallery
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
