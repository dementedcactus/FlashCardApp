//
//  AddCardView.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/18/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class AddCardView: DismissViewTemplate {

    lazy var cardNameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Add Card"
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.textColor = .white
        lb.font = .boldSystemFont(ofSize: 20)
        return lb
    }()
    
    lazy var deckLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Deck:"
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.textColor = .white
        lb.font = .systemFont(ofSize: 20)
        return lb
    }()
    
    lazy var decksToPickFromButton: UIButton = {
        let button = UIButton()
        button.setTitle("Decks", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.263, green: 0.353, blue: 0.576, alpha: 1.00)
        return button
    }()
    
    //Tableview for DecksToPickFrom
    //Starts off hidden. When the Decks button is clicked it should show all available decks. Clicking on any cell makes it disappear again and change the Button Title to the selected cell's text
    lazy var availableDecksTableView: UITableView = {
        let tv = UITableView()
        //create and register a cell
        tv.register(CustomTableViewCell.self, forCellReuseIdentifier: "DeckCell")
        tv.isHidden = true
        tv.tag = 1
        tv.backgroundColor = .clear
        tv.separatorColor = .clear
        return tv
    }()
    
    lazy var frontLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Front Side"
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.textColor = .white
        lb.font = .boldSystemFont(ofSize: 20)
        return lb
    }()
    
    lazy var frontTextField: UITextField = {
        let textfield = UITextField()
        textfield.layer.shadowColor = UIColor.gray.cgColor
        textfield.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        textfield.layer.shadowOpacity = 1.0
        textfield.layer.shadowRadius = 0.0
        textfield.backgroundColor = Stylesheet.Colors.White
        textfield.textAlignment = NSTextAlignment.center
        textfield.font = Stylesheet.Fonts.TextfieldFont
        textfield.textColor = Stylesheet.Colors.Dark
        textfield.adjustsFontSizeToFitWidth = true
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.keyboardType = .asciiCapable
        textfield.returnKeyType = .default
        textfield.placeholder = "e.g. 2 + 2"
        return textfield
    }()
    
    lazy var backLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Back Side"
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.textColor = .white
        lb.font = .boldSystemFont(ofSize: 20)
        return lb
    }()
    
    lazy var backTextField: UITextField = {
        let textfield = UITextField()
        textfield.layer.shadowColor = UIColor.gray.cgColor
        textfield.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        textfield.layer.shadowOpacity = 1.0
        textfield.layer.shadowRadius = 0.0
        textfield.backgroundColor = Stylesheet.Colors.White
        textfield.textAlignment = NSTextAlignment.center
        textfield.font = Stylesheet.Fonts.TextfieldFont
        textfield.textColor = Stylesheet.Colors.Dark
        textfield.adjustsFontSizeToFitWidth = true
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.keyboardType = .asciiCapable
        textfield.returnKeyType = .default
        textfield.placeholder = "e.g. is 4"
        return textfield
    }()
    
    lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Category", for: .normal)
        Stylesheet.Objects.Buttons.CreateButton.style(button: button)
        return button
    }()
    
    //Tableview for Categories
    //Starts off hidden. When the category button is clicked it appears. Clicking on any cell makes it disappear again and change the Button Title to the selected cell's text
    lazy var categoryTableView: UITableView = {
        let tv = UITableView()
        //create and register a cell
        tv.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        tv.isHidden = true
        tv.tag = 2
        tv.backgroundColor = .clear
        return tv
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Card", for: .normal)
        Stylesheet.Objects.Buttons.CreateButton.style(button: button)
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
        addSubview(cardNameLabel)
        addSubview(deckLabel)
        addSubview(decksToPickFromButton)
        addSubview(frontLabel)
        addSubview(frontTextField)
        addSubview(backLabel)
        addSubview(backTextField)
        addSubview(categoryButton)
        addSubview(categoryTableView)
        addSubview(availableDecksTableView)
        addSubview(addButton)
        
        cardNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
        }
        deckLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cardNameLabel.snp.bottom)
            make.leading.equalTo(containerView.snp.leading)
            make.width.equalTo(containerView.snp.width).multipliedBy(0.3)
        }
        decksToPickFromButton.snp.makeConstraints { (make) in
            make.leading.equalTo(deckLabel.snp.trailing)
            make.top.equalTo(deckLabel.snp.top)
            make.bottom.equalTo(deckLabel.snp.bottom)
            make.width.equalTo(containerView.snp.width).multipliedBy(0.6)
        }
        availableDecksTableView.snp.makeConstraints { (make) in
            make.top.equalTo(decksToPickFromButton.snp.bottom)
            make.leading.equalTo(decksToPickFromButton.snp.leading)
            make.trailing.equalTo(decksToPickFromButton.snp.trailing)
            make.bottom.equalTo(containerView.snp.bottom)
        }
        frontLabel.snp.makeConstraints { (make) in
            make.top.equalTo(deckLabel.snp.bottom).offset(10)
            make.leading.equalTo(containerView.snp.leading)
            make.width.equalTo(containerView.snp.width).multipliedBy(1)
        }
        frontTextField.snp.makeConstraints { (make) in
            make.top.equalTo(frontLabel.snp.bottom).offset(10)
            make.centerX.equalTo(containerView.snp.centerX)
            make.width.equalTo(containerView.snp.width).multipliedBy(0.8)
        }
        backLabel.snp.makeConstraints { (make) in
            make.top.equalTo(frontTextField.snp.bottom).offset(10)
            make.leading.equalTo(containerView.snp.leading)
            make.width.equalTo(containerView.snp.width).multipliedBy(1)
        }
        backTextField.snp.makeConstraints { (make) in
            make.top.equalTo(backLabel.snp.bottom).offset(10)
            make.centerX.equalTo(containerView.snp.centerX)
            make.width.equalTo(containerView.snp.width).multipliedBy(0.8)
        }
        categoryButton.snp.makeConstraints { (make) in
            make.top.equalTo(backTextField.snp.bottom).offset(10)
            make.centerX.equalTo(containerView.snp.centerX)
            make.width.equalTo(containerView.snp.width).multipliedBy(0.8)
        }
        categoryTableView.snp.makeConstraints { (make) in
            make.top.equalTo(categoryButton.snp.bottom)
            make.centerX.equalTo(containerView.snp.centerX)
            make.width.equalTo(categoryButton.snp.width).multipliedBy(1)
            make.bottom.equalTo(containerView.snp.bottom)
        }
        addButton.snp.makeConstraints { (make) in
            make.top.equalTo(categoryTableView.snp.bottom).offset(10)
            make.centerX.equalTo(containerView.snp.centerX)
            make.width.equalTo(containerView.snp.width).multipliedBy(0.5)
        }
        
        
    }
    
}
