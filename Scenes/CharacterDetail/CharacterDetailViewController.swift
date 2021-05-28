//
//  CharacterDetailViewController.swift
//  rmcase
//
//  Created by ANIL Turan on 27.05.2021.
//

import Foundation
import UIKit

final class CharacterDetailViewController: BaseViewController {
    
    var characterNameLabel = UILabel()
    var characterImageView = UIImageView()
    var characterStateLabel = UILabel()
    var characterGenderLabel = UILabel()
    
    var doneButton = UIButton()
    var episodesButton = UIButton()
    var episodesView = UIView()
    var episodesTableView = UITableView()
    var episodesViewHeightConstarint: Double = 60
    
    var characterID: Int!
    
    let characterDetailVM = CharacterDetailViewModel()
    
    let tableViewSeparator = UIImageView()
    let buttonArrowImageView = UIImageView(image: UIImage(named: "upArrow"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCharacterDetail()
        setInterface()
    }
    
    func getCharacterDetail() {
        loading()
        characterDetailVM.getCharacter(id: String(format: "%d", self.characterID)) {
            
            self.characterDetailVM.getEpisodeNames {
                DispatchQueue.main.async {
                    self.episodesTableView.reloadData()
                    self.loaded()
                }
            }
            
            DispatchQueue.main.async {
                self.fillPage(with: self.characterDetailVM.character!)
            }
        }
        
        
    }
    
    func setInterface() {
        view.backgroundColor = UIColor.getUIColor(color: "131415")
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor.getUIColor(color: "8a67be"), for: .normal)
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.top.equalTo(view).offset(8)
        }
        
        characterNameLabel.font = UIFont.boldSystemFont(ofSize: 28.0)
        characterNameLabel.textColor = .white
        characterNameLabel.numberOfLines = 0
        view.addSubview(characterNameLabel)
        characterNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(doneButton.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        characterImageView.layer.cornerRadius = 45.0
        characterImageView.clipsToBounds = true
        characterImageView.contentMode = .scaleAspectFill
        view.addSubview(characterImageView)
        characterImageView.snp.makeConstraints { (make) in
            make.left.equalTo(characterNameLabel)
            make.top.equalTo(characterNameLabel.snp.bottom).offset(20)
            make.width.height.equalTo(90)
        }
        
        characterStateLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        characterStateLabel.textColor = .white
        characterStateLabel.numberOfLines = 0
        view.addSubview(characterStateLabel)
        characterStateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(characterImageView.snp.right).offset(18)
            make.top.equalTo(characterNameLabel.snp.bottom).offset(43)
            make.right.equalTo(view).offset(-20)
        }
        
        characterGenderLabel.font = UIFont.systemFont(ofSize: 16.0)
        characterGenderLabel.textColor = .white
        characterGenderLabel.numberOfLines = 0
        view.addSubview(characterGenderLabel)
        characterGenderLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(characterStateLabel)
            make.top.equalTo(characterStateLabel.snp.bottom).offset(14)
        }
        
        episodesView.clipsToBounds = true
        episodesView.backgroundColor = UIColor.getUIColor(color: "1c1e1f")
        episodesView.layer.cornerRadius = 12.0
        view.addSubview(episodesView)
        episodesView.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(characterImageView.snp.bottom).offset(30)
            make.height.equalTo(60)
        }
        
        episodesButton.addTarget(self, action: #selector(episodesTapped), for: .touchUpInside)
        episodesButton.setTitle("Episodes", for: .normal)
        episodesButton.contentHorizontalAlignment = .left
        episodesButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        episodesView.addSubview(episodesButton)
        episodesButton.snp.makeConstraints { (make) in
            make.top.left.equalTo(episodesView)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(60)
        }
        
        episodesButton.addSubview(buttonArrowImageView)
        buttonArrowImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(episodesButton)
            make.right.equalTo(episodesButton).offset(-16)
        }
        
        setupTableView()
        
        view.addSubview(spinner)
        spinner.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(view)
        }
    }
    
    func fillPage(with character: Character) {
        characterNameLabel.text = character.name
        
        DispatchQueue.global().async {
            if let url = URL(string: character.imageUrl),
               let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.characterImageView.image = UIImage(data: data)
                }
            }
        }
        
        characterStateLabel.text = character.status + ", " + character.species
        characterGenderLabel.text = character.gender
    }
    
    func setupTableView() {
        episodesTableView.backgroundColor = UIColor.getUIColor(color: "1c1e1f")
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
        episodesTableView.separatorStyle = .none
        
        episodesView.addSubview(episodesTableView)
        episodesTableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(episodesView)
            make.top.equalTo(episodesButton.snp.bottom).offset(5)
            make.height.equalTo(180)
        }
        
        tableViewSeparator.backgroundColor = UIColor.getUIColor(color: "353535")
        episodesTableView.addSubview(tableViewSeparator)
        tableViewSeparator.snp.makeConstraints { (make) in
            make.left.equalTo(episodesTableView).offset(18)
            make.height.equalTo(1)
            make.width.equalTo(100)
            make.top.equalTo(episodesTableView)
        }
        
    }
    
    @objc func episodesTapped() {
        
        if episodesViewHeightConstarint == 60 {
            episodesViewHeightConstarint = characterDetailVM.getTableViewHeight()
            buttonArrowImageView.image = UIImage(named: "downArrow")
        } else {
            episodesViewHeightConstarint = 60
            buttonArrowImageView.image = UIImage(named: "upArrow")
        }
        
        self.episodesView.snp.updateConstraints { (make) in
            make.height.equalTo(episodesViewHeightConstarint)
        }
        
        UIView.animate(withDuration: 0.5) { [self] in
            self.episodesView.superview?.layoutIfNeeded()
        }
        
    }
    
    @objc func doneTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CharacterDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterDetailVM.episodes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = characterDetailVM.episodes![indexPath.row].getEpisodeName()
        cell.textLabel?.textColor = .white
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        cell.backgroundColor = .clear
        return cell
    }
    
    
}
