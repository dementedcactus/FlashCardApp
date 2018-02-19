//
//  DismissViewTemplate.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/18/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class DismissViewTemplate: UIView {

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
    }
    
    private func constrainObjects() {
        containerView.snp.makeConstraints { (make) in
            make.center.equalTo(self.safeAreaLayoutGuide.snp.center)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.8)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
        }
    }

}
