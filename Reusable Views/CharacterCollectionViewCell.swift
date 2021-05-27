//
//  CharacterCollectionViewCell.swift
//  rmcase
//
//  Created by ANIL Turan on 27.05.2021.
//

import UIKit

final class CharacterCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(imageView.snp.width).multipliedBy(1.14)
        }
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = .white
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(imageView.snp.bottom).offset(10)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillCell(with character: Character) {
        titleLabel.text = character.name
        
        if let url = URL(string: character.imageUrl) {
            ImageDownloader().downloadImage(from: url) { (image) in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    
    func fillCell() {
        imageView.image = UIImage(named: "test")
        titleLabel.text = "Rick Sanchez"
    }
}
