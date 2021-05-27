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
    
    var episodesScrollView = UIScrollView()
    var episodeStackView: UIStackView?
    var scrollViewHeightConstarint = 60.0
    
    var characterID: Int!
    
    let characterDetailVM = CharacterDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCharacterDetail()
        setInterface()
    }
    
    func getCharacterDetail() {
        characterDetailVM.getCharacter(id: String(format: "%d", self.characterID)) {
            
            self.characterDetailVM.getEpisodeNames {
                DispatchQueue.main.async {
                    self.fillScrollView()
                }
            }
            
            DispatchQueue.main.async {
                self.fillPage(with: self.characterDetailVM.character!)
            }
        }
        
        
    }
    
    func setInterface() {
        view.backgroundColor = UIColor(hex: "#131415")
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor(hex: "#8a67be"), for: .normal)
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
            make.top.equalTo(view).offset(44)
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
        
        episodesScrollView.showsVerticalScrollIndicator = false
        episodesScrollView.layer.cornerRadius = 12.0
        episodesScrollView.clipsToBounds = true
        episodesScrollView.backgroundColor = UIColor(hex: "#1c1e1f")
        view.addSubview(episodesScrollView)
        episodesScrollView.snp.makeConstraints { (make) in
            make.left.equalTo(characterImageView)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(characterImageView.snp.bottom).offset(30)
            make.height.equalTo(60)
        }
        
        episodesButton.addTarget(self, action: #selector(episodesTapped), for: .touchUpInside)
        episodesButton.setTitle("Episodes", for: .normal)
        episodesButton.contentHorizontalAlignment = .left
        episodesButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        view.addSubview(episodesButton)
        episodesButton.snp.makeConstraints { (make) in
            make.top.left.equalTo(episodesScrollView)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(scrollViewHeightConstarint)
        }
    }
    
    func fillScrollView() {
        
        var episodeLabels: [UILabel] = []
        
        if let episodes = characterDetailVM.episodes {
            for item in episodes {
                let label = UILabel()
                label.font = UIFont.boldSystemFont(ofSize: 14.0)
                label.textColor = .white
                label.text = item.getEpisodeName()
                label.textAlignment = .left
                episodeLabels.append(label)
            }
        }
        
        episodeStackView = UIStackView(arrangedSubviews: episodeLabels)
        episodeStackView?.axis  = .vertical
        episodeStackView?.alignment = .leading
        episodeStackView?.distribution  = .fillEqually
        episodeStackView?.alignment = UIStackView.Alignment.center
        episodeStackView?.spacing   = 10.0
        episodesScrollView.addSubview(episodeStackView!)
        episodeStackView?.snp.makeConstraints { (make) in
            make.top.equalTo(episodesButton.snp.bottom).offset(25)
            make.left.right.bottom.equalTo(episodesScrollView)
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
    
    @objc func episodesTapped() {
        if scrollViewHeightConstarint == 60 {
            let newHeight = Double(((characterDetailVM.episodes?.count ?? 0) + 1) * 28) + 60
            scrollViewHeightConstarint = newHeight
            
        } else {
            scrollViewHeightConstarint = 60
        }
        UIView.animate(withDuration: 0.5) { [self] in
            self.episodesScrollView.snp.updateConstraints { (make) in
                make.height.equalTo(scrollViewHeightConstarint)
            }
            
            episodesScrollView.layoutIfNeeded()
        }
        
    }
    
    @objc func doneTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
