//
//  CollectionViewCell.swift
//  homework3
//
//  Created by Dariya on 14/1/24.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = String(describing: ProductCollectionViewCell.self)
    
    private let productTitle: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textColor = .black
        view.text = "lmsf;la;fa;fa"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productDescription: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .medium)
        view.textColor = .black
        view.text = "lmsf;la;fa;fa"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(productTitle)
        contentView.addSubview(productImage)
        contentView.addSubview(productDescription)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            productTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            productImage.topAnchor.constraint(equalTo: productTitle.bottomAnchor, constant: 10),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            productImage.heightAnchor.constraint(equalToConstant: 100),
            productImage.widthAnchor.constraint(equalToConstant: 100),
            
            productDescription.topAnchor.constraint(equalTo: productTitle.bottomAnchor, constant: 10),
            productDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    func fill(_ item: ProductItem) {
        productTitle.text = item.productTitle
        productImage.image = UIImage(systemName: item.productImage)
        productDescription.text = item.productDescription
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
