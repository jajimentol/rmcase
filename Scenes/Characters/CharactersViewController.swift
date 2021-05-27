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
    
    let flowLayout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let emptyLabel = UILabel()
    
    lazy var spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInterface()
        getCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func getCharacters() {
        loading()
        charactersVM.getCharacters(completionHandler: { [weak self] isEmpty in
            guard let strongSelf = self else { return }
            if isEmpty {
                strongSelf.emptyState()
            } else {
                strongSelf.reloadCollectionView()
            }
        })
    }
    
    func setInterface() {
        
        view.backgroundColor = UIColor(named: "#131415")
        
        titleLabel.text = "Characters"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        titleLabel.textColor = .white
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.top.equalTo(view).offset(110)
        }
        
        setupCollectionView()
        setupEmptyLabel()
        
        view.addSubview(spinner)
        spinner.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(view)
        }
    }
    
    func setupCollectionView() {
        let itemWidth = (screenWidth - 60) / 2
        let itemHeight = itemWidth * 1.38
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 10
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.setCollectionViewLayout(flowLayout, animated: false)
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.bottom.equalTo(view)
        }
        collectionView.reloadData()
    }
    
    func loading() {
        spinner.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func loaded() {
        spinner.stopAnimating()
        view.isUserInteractionEnabled = true
    }
    
    func emptyState() {
        DispatchQueue.main.async {
            self.emptyLabel.isHidden = false
            self.collectionView.isHidden = true
        }
    }
    
    func setupEmptyLabel() {
        emptyLabel.text = "No characters available"
        emptyLabel.textColor = .white
        emptyLabel.isHidden = true
        view.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(view)
        }
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.loaded()
            self.collectionView.reloadData()
        }
    }
}

extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charactersVM.characterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.item == charactersVM.characterList.count - 5) {
            getCharacters()
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CharacterCollectionViewCell else { return UICollectionViewCell() }
        let character = charactersVM.characterList[indexPath.item]
        cell.fillCell(with: character)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = CharacterDetailViewController()
        detailVC.characterID = charactersVM.characterList[indexPath.item].id
        self.present(detailVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    
}
