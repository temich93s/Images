//
//  ImagesViewController.swift
//  Images
//
//  Created by 2lup on 30.10.2022.
//

import UIKit

// MARK: - ImagesViewController

/// Основное ViewController  с 6 изображениями из интернета
final class ImagesViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let titleText = "ImagesIOS"
        static let whiteColorName = "WhiteColor"
        static let imagesCollectionViewCellText = "imagesMovieCollectionViewCell"
        static let setID: [String] = ["id1", "id2", "id3", "id4", "id5", "id6"]
    }
    
    // MARK: - Private Visual Properties
    private let imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor(named: Constants.whiteColorName)
        collectionView.register(
            ImagesCollectionViewCell.self,
            forCellWithReuseIdentifier: Constants.imagesCollectionViewCellText
        )
        return collectionView
    }()
    
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Private Properties
    private var items = Constants.setID
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private Methods
    @objc private func refreshAction() {
        items = Constants.setID
        imagesCollectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    private func setupView() {
        title = Constants.titleText
        view.backgroundColor = UIColor(named: Constants.whiteColorName)
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        view.addSubview(imagesCollectionView)
        imagesCollectionView.addSubview(refreshControl)
        createImagesCollectionViewConstraint()
    }
    
    func createImagesCollectionViewConstraint() {
        imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagesCollectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            imagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imagesCollectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10)
        ])
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.imagesCollectionViewCellText, for: indexPath) as? ImagesCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configureImagesCollectionViewCell(idCell: items[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let cell = collectionView.cellForItem(at: indexPath) as? ImagesCollectionViewCell
        cell?.leadingAnchorImageImageView.constant = collectionView.frame.width
        cell?.trailingAnchorImageImageView.constant = collectionView.frame.width
        UIView.animate(withDuration: 2) {
            cell?.contentView.layoutIfNeeded()
        } completion: { _ in
            guard indexPath.row < self.items.count else { return }
            self.items.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
            cell?.leadingAnchorImageImageView.constant = 0
            cell?.trailingAnchorImageImageView.constant = 0
        }
    }
}
