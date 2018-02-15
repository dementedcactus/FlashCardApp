//
//  AllDeckView.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/13/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import SnapKit

class AllDecksView: UIView {

    lazy var containerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .blue
        return cv
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        button.backgroundColor = .clear
        button.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        return button
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        button.backgroundColor = .clear
        button.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(CustomTableViewCell.self, forCellReuseIdentifier: "DeckCell")
        tv.backgroundColor = .white
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupObjects()
        setupViews()
    }
    private func setupObjects() {
        addSubview(containerView)
        addSubview(menuButton)
        addSubview(plusButton)
        addSubview(tableView)
        
    }
    private func setupViews() {
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.14)
        }
        
        menuButton.snp.makeConstraints { (make) in
            make.leading.equalTo(containerView.snp.leading)
            make.top.equalTo(containerView.snp.top).offset(20)
            make.bottom.equalTo(containerView.snp.bottom)
            make.width.equalTo(menuButton.snp.height)
        }
        
        plusButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(containerView.snp.trailing)
            make.top.equalTo(containerView.snp.top).offset(20)
            make.bottom.equalTo(containerView.snp.bottom)
            make.width.equalTo(plusButton.snp.height)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.bottom)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }

}
