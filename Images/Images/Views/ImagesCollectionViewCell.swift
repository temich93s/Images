//
//  ImagesCollectionViewCell.swift
//  Images
//
//  Created by 2lup on 30.10.2022.
//

import UIKit

// MARK: - ImagesCollectionViewCell

/// Ячейка с картинкой
class ImagesCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        static let fatalErrorText = "init(coder:) has not been implemented"
        static let placeholderImageName = "PlaceholderImage"
        static let picsumPhotosText = "https://picsum.photos/800"
    }
    
    // MARK: - Private Visual Properties
    private let imageImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var numberRowLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    
    // MARK: - Public Properties
    lazy var leadingAnchorImageImageView = imageImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0)
    
    lazy var trailingAnchorImageImageView = imageImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
    
    // MARK: - Private Properties
    private let cache = NSCache<NSString, UIImage>()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }
    
    // MARK: - Public Methods
    func configureImagesCollectionViewCell(idCell: String) {
        numberRowLabel.text = "\(idCell)"
        if let cachedImage = cache.object(forKey: "\(idCell)" as NSString) {
            imageImageView.image = cachedImage
        } else {
            imageImageView.image = UIImage(named: Constants.placeholderImageName)
            guard let url = URL(string: Constants.picsumPhotosText) else { return }
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    guard let safeData = data, let imageCell = UIImage(data: safeData) else { return }
                    self.imageImageView.image = imageCell
                    self.cache.setObject(imageCell, forKey: "\(idCell)" as NSString)
                }
            }
        }
    }
    
    // MARK: - Private Methods
    private func initView() {
        contentView.addSubview(imageImageView)
        contentView.addSubview(numberRowLabel)
        createConstraints()
    }
    
    private func createConstraints() {
        imageImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            leadingAnchorImageImageView,
            trailingAnchorImageImageView
        ])
        
        numberRowLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberRowLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            numberRowLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            numberRowLabel.widthAnchor.constraint(equalToConstant: 30),
            numberRowLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

