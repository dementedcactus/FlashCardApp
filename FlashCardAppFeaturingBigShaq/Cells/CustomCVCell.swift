//
//  CollectionsCustomCollectionViewCell.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/22/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class CustomCVCell: UICollectionViewCell {
    
    lazy var containerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .blue
        return cv
    }()
    
    lazy var questionTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Sample Question Text Here"
        Stylesheet.Objects.Textviews.Completed.style(textview: tv)
        tv.isEditable = false
        tv.font = .systemFont(ofSize: 10)
        return tv
    }()
    
    lazy var answerTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Sample Answer Text Here"
        Stylesheet.Objects.Textviews.Completed.style(textview: tv)
        tv.isEditable = false
        tv.font = .systemFont(ofSize: 10)
        return tv
    }()
    
    lazy var categoryLabel: UILabel = {
        let lb = UILabel()
        lb.backgroundColor = .clear
        lb.numberOfLines = 0
        lb.font = .systemFont(ofSize: 10)
        lb.text = "Category"
        lb.textColor = .white
        lb.textAlignment = .center
        return lb
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
        addSubview(questionTextView)
        addSubview(answerTextView)
        addSubview(categoryLabel)
    }
    
    private func setupViews() {
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        questionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.4)
        }
        
        answerTextView.snp.makeConstraints { (make) in
            make.top.equalTo(questionTextView.snp.bottom).offset(1)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.4)
        }
        
        categoryLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(containerView.snp.bottom)
            make.top.equalTo(answerTextView.snp.bottom)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
        }
    }
}
