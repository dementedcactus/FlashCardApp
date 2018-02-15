//
//  AddingThingsView.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/15/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class AddingThingsView: UIView {

    lazy var dismissView: UIButton = {
        let button = UIButton(frame: UIScreen.main.bounds) //This tells the button to be the size of the screen
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(red: 0.859, green: 0.859, blue: 0.969, alpha: 1.00)
        return view
    }()
    
    lazy var createLabel: UILabel = {
        let cl = UILabel()
        cl.text = "Create Deck"
        cl.textColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1.00)
        cl.numberOfLines = 0
        cl.font = .boldSystemFont(ofSize: 20) //.italicSystemFont(ofSize: 20)
        cl.textAlignment = .center
        cl.backgroundColor = .clear
        cl.layer.shadowColor = UIColor(red: 0.459, green: 0.459, blue: 0.469, alpha: 1.00).cgColor
        cl.layer.shadowRadius = 3.0
        cl.layer.shadowOpacity = 1.0
        cl.layer.shadowOffset = CGSize(width: 4, height: 4)
        cl.layer.masksToBounds = false
        return cl
    }()
    
    lazy var addLabel: UILabel = {
        let al = UILabel()
        al.text = "Add"
        al.textColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1.00)
        al.numberOfLines = 0
        al.font = .italicSystemFont(ofSize: 20)
        al.textAlignment = .center
        al.backgroundColor = .clear
        al.layer.shadowColor = UIColor(red: 0.459, green: 0.459, blue: 0.469, alpha: 1.00).cgColor
        al.layer.shadowRadius = 3.0
        al.layer.shadowOpacity = 1.0
        al.layer.shadowOffset = CGSize(width: 4, height: 4)
        al.layer.masksToBounds = false
        return al
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
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight) // .light, .dark, .prominent, .regular, .extraLight
        let visualEffect = UIVisualEffectView(frame: UIScreen.main.bounds)
        visualEffect.effect = blurEffect
        addSubview(visualEffect)
    }

    private func setupObjects() {
        addSubview(dismissView)
        addSubview(containerView)
        addSubview(createLabel)
        addSubview(addLabel)
        
    }
    
    private func constrainObjects() {
        
        containerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.4)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.4)
        }
        
        createLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(containerView.snp.leading)
            make.top.equalTo(containerView.snp.top).offset(10)
            make.width.equalTo(containerView.snp.width)
        }
        
        addLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(containerView.snp.leading)
            make.top.equalTo(createLabel.snp.bottom).offset(10)
            make.width.equalTo(containerView.snp.width)
        }
        

    }
    
    
}
