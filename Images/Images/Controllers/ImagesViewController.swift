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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        title = Constants.titleText
        view.backgroundColor = UIColor(named: Constants.whiteColorName)
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        view.addSubview(imagesCollectionView)
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
        6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.imagesCollectionViewCellText, for: indexPath) as? ImagesCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configureImagesCollectionViewCell()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
    }
}
