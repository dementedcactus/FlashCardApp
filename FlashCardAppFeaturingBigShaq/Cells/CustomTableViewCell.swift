//
//  CustomTVC.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/14/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {

    //Deck Label
    lazy var deckLabel: UILabel = {
        let dl = UILabel()
        dl.text = "Test Label"
        dl.textColor = .black
        dl.numberOfLines = 0
        dl.font = .boldSystemFont(ofSize: 17)
        dl.textAlignment = .left
        dl.backgroundColor = .white
        return dl
    }()
    
    //Number of Cards in Deck Label
    lazy var numberOfCardsInDeckLabel: UILabel = {
        let nocidl = UILabel()
        nocidl.text = "37"
        nocidl.textColor = .black
        nocidl.numberOfLines = 0
        nocidl.font = .italicSystemFont(ofSize: 17)
        nocidl.textAlignment = .center
        nocidl.backgroundColor = .white
        return nocidl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: "DeckCell")
        setupAndConstrainObjects()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAndConstrainObjects()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //you get the frame of the UI elements here
        //        cityImageView.layer.cornerRadius = cityImageView.bounds.width / 2.0
        //        cityImageView.layer.masksToBounds = true // keeps the image withing th bounds
        setupAndConstrainObjects()
    }
    
    private func setupAndConstrainObjects() {
        addSubview(deckLabel)
        addSubview(numberOfCardsInDeckLabel)
        
        deckLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(self.snp.width).multipliedBy(0.6)
        }
        
        numberOfCardsInDeckLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.snp.trailing)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(self.snp.width).multipliedBy(0.3)
        }
        
    }
    
}
