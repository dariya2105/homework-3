//
//  ViewController.swift
//  homework3
//
//  Created by Dariya on 13/1/24.
//

import UIKit

class ProductViewController: UIViewController {
    
    private let network = NetworkService()
    
    private var products: [ProductItem] = []
    
    private let collectionView: UICollectionView = {
        let view = UICollectionViewFlowLayout()
        view.scrollDirection = .vertical
        view.itemSize = .init(width: 250, height: 250)
        view.minimumLineSpacing = 20
        let collection = UICollectionView(frame: .zero, collectionViewLayout: view)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .systemGray4
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseID)
        fetchProduct()
        print("dariya")
        print("Dariya")
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchProduct() {
        network.fetchProducts { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let model):
                self.products = model
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                print(model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateProduct(_ product: ProductItem) {
        network.updateProduct(with: product) { result in
            switch result {
            case .success(let model):
                print(model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func addProduct(_ product: ProductItem) {
        network.addNewProduct(with: product) { result in
            switch result {
            case .success(let model):
                print(model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func deleteProduct(_ product: ProductItem) {
        network.deleteProduct(with: product) { result in
            switch result {
            case .success(let model):
                print(model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseID, for: indexPath) as! ProductCollectionViewCell
        let item = products[indexPath.item]
        cell.fill(item)
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }
}
