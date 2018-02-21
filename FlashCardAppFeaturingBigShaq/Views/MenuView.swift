//
//  MenuView.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/13/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import SnapKit

class MenuView: UIView {

    lazy var dismissView: UIButton = {
        let button = UIButton(frame: UIScreen.main.bounds) //This tells the button to be the size of the screen
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.910, green: 0.412, blue: 0.204, alpha: 1.00)
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var menuImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "nicole")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var decksButton: UIButton = {
        let button = UIButton()
        button.setTitle("Decks", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.263, green: 0.353, blue: 0.576, alpha: 1.00)
        return button
    }()
    
    lazy var cardBrowserButton: UIButton = {
        let button = UIButton()
        button.setTitle("Card Browser", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.325, green: 0.690, blue: 0.875, alpha: 1.00)
        return button
    }()
    
    lazy var nightModeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Night Mode", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.263, green: 0.353, blue: 0.576, alpha: 1.00)
        return button
    }()
    
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Settings", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.325, green: 0.690, blue: 0.875, alpha: 1.00)
        return button
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.263, green: 0.353, blue: 0.576, alpha: 1.00)
        return button
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
        backgroundColor = .clear
        setupViews()
    }
    
    private func setupViews() {
        setupBlurEffectView()
        setupObjects()
        constrainObjects()
    }

    private func setupBlurEffectView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light) // .light, .dark, .prominent, .regular, .extraLight
        let visualEffect = UIVisualEffectView(frame: UIScreen.main.bounds)
        visualEffect.effect = blurEffect
        addSubview(visualEffect)
    }
    
    private func setupObjects() {
        addSubview(dismissView)
        addSubview(containerView)
        addSubview(menuImageView)
        addSubview(decksButton)
        addSubview(cardBrowserButton)
        addSubview(nightModeButton)
        addSubview(settingsButton)
        addSubview(logoutButton)
    }
    
    private func constrainObjects() {
        
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.7)
        }
        
        menuImageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(containerView)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.3)
        }
        
        decksButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(containerView)
            make.top.equalTo(menuImageView.snp.bottom)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.1)
        }
        
        cardBrowserButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(containerView)
            make.top.equalTo(decksButton.snp.bottom)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.1)
        }
        
        nightModeButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(containerView)
            make.top.equalTo(cardBrowserButton.snp.bottom)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.1)
        }
        
        settingsButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(containerView)
            make.top.equalTo(nightModeButton.snp.bottom)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.1)
        }
        
        logoutButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(containerView)
            make.top.equalTo(settingsButton.snp.bottom)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.1)
        }
        
    }
    
}
