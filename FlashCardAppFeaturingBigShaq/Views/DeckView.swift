//
//  DeckView.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/13/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import SnapKit

class DeckView: UIView {
    
    //When you click on a deck this should appear
    //This will be where cards are presented with the questions on one ContainerView
    //The answers will be on the bottom half with a switch where the user can select of they got it right or wrong
    
    lazy var containerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .blue
        return cv
    }()
    
    lazy var questionTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Sample Question Text Here"
        Stylesheet.Objects.Textviews.Completed.style(textview: tv)
        return tv
    }()
    
    lazy var answerTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Sample Answer Text Here"
        Stylesheet.Objects.Textviews.Completed.style(textview: tv)
        return tv
    }()
    
    lazy var showAnswerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Answer", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.263, green: 0.353, blue: 0.576, alpha: 1.00)
        return button
    }()
    
    lazy var previousButton: UIButton = {
        let button = UIButton()
        //button.setTitle("Previous", for: .normal)
        button.setImage(#imageLiteral(resourceName: "back30"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.263, green: 0.353, blue: 0.576, alpha: 1.00)
        return button
    }()

    lazy var nextQuestionButton: UIButton = {
        let button = UIButton()
        //button.setTitle("Next", for: .normal)
        button.setImage(#imageLiteral(resourceName: "forward30"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.325, green: 0.690, blue: 0.875, alpha: 1.00)
        return button
    }()
    
    lazy var repeatButton: UIButton = {
        let button = UIButton()
        button.setTitle("Repeat", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.325, green: 0.690, blue: 0.875, alpha: 1.00)
        return button
    }()
    
    lazy var fakeStackView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .green
        return cv
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
        addSubview(answerTextView)
        addSubview(questionTextView)
        
        addSubview(fakeStackView)
        
        addSubview(previousButton)
        addSubview(repeatButton)
        addSubview(showAnswerButton)
        addSubview(nextQuestionButton)
        
    }
    
    private func setupViews() {
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.40)
        }
        
        answerTextView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(5)
            make.leading.equalTo(containerView.snp.leading).offset(5)
            make.trailing.equalTo(containerView.snp.trailing).offset(-5)
            make.bottom.equalTo(containerView.snp.bottom).offset(-5)
        }
        
        questionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(5)
            make.leading.equalTo(containerView.snp.leading).offset(5)
            make.trailing.equalTo(containerView.snp.trailing).offset(-5)
            make.bottom.equalTo(containerView.snp.bottom).offset(-5)
        }
        
        fakeStackView.snp.makeConstraints { (make) in
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.08)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        previousButton.snp.makeConstraints { (make) in
            //make.height.equalTo(fakeStackView.snp.height).multipliedBy(0.08)
            make.width.equalTo(fakeStackView.snp.width).multipliedBy(0.15)
            make.bottom.equalTo(fakeStackView.snp.bottom)
            make.leading.equalTo(fakeStackView.snp.leading)
            make.top.equalTo(fakeStackView.snp.top)
        }
        
        repeatButton.snp.makeConstraints { (make) in
            //make.height.equalTo(fakeStackView.snp.height).multipliedBy(0.08)
            make.width.equalTo(fakeStackView.snp.width).multipliedBy(0.35)
            make.bottom.equalTo(fakeStackView.snp.bottom)
            make.leading.equalTo(previousButton.snp.trailing)
            make.top.equalTo(fakeStackView.snp.top)
        }
        
        showAnswerButton.snp.makeConstraints { (make) in
            //make.height.equalTo(fakeStackView.snp.height).multipliedBy(0.08)
            make.width.equalTo(fakeStackView.snp.width).multipliedBy(0.35)
            make.bottom.equalTo(fakeStackView.snp.bottom)
            make.leading.equalTo(repeatButton.snp.trailing)
            make.top.equalTo(fakeStackView.snp.top)
        }
        
        nextQuestionButton.snp.makeConstraints { (make) in
            //make.height.equalTo(fakeStackView.snp.height).multipliedBy(0.08)
            make.width.equalTo(fakeStackView.snp.width).multipliedBy(0.15)
            make.bottom.equalTo(fakeStackView.snp.bottom)
            make.leading.equalTo(showAnswerButton.snp.trailing)
            make.top.equalTo(fakeStackView.snp.top)
        }
        
        
    
    }

}
