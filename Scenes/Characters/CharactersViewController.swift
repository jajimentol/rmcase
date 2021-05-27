//
//  CharactersViewController.swift
//  rmcase
//
//  Created by ANIL Turan on 27.05.2021.
//

import Foundation
import UIKit

final class CharactersViewController: BaseViewController {
    
    let charactersVM = CharactersViewModel()
    
    let titleLabel = UILabel()
    
    let collectionView = UICollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInterface()
    }
    
    func setInterface() {
        
        view.backgroundColor = UIColor(hex: "131415")
        
        titleLabel.text = "Characters"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        titleLabel.backgroundColor = .white
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.top.equalTo(view).offset(65)
        }
        
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
    }
}
