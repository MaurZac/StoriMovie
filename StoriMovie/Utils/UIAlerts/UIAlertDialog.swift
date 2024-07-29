//
//  UIAlertDialog.swift
//  StoriMovie
//
//  Created by MaurZac on 28/07/24.
//

import UIKit

class UIAlertDialog: UIViewController {
    
    private let containerView = UIView()
    private let closeButton = UIButton(type: .system)
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let firstButton = UIButton(type: .system)
    private let secondButton = UIButton(type: .system)
    
    private var firstButtonAction: (() -> Void)?
    private var secondButtonAction: (() -> Void)?
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var descriptionText: String? {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    
    var firstButtonTitle: String? {
        didSet {
            firstButton.setTitle(firstButtonTitle, for: .normal)
            firstButton.isHidden = firstButtonTitle == nil
            
            print("First Button Title: \(firstButton.title(for: .normal) ?? "nil")")
            print("Second Button Title: \(secondButton.title(for: .normal) ?? "nil")")
        }
    }
    
    var secondButtonTitle: String? {
        didSet {
            secondButton.setTitle(secondButtonTitle, for: .normal)
            secondButton.isHidden = secondButtonTitle == nil
            
            print("First Button Title: \(firstButton.title(for: .normal) ?? "nil")")
            print("Second Button Title: \(secondButton.title(for: .normal) ?? "nil")")
        }
    }
    
    init(firstButtonTitle: String?, secondButtonTitle: String?, firstButtonAction: (() -> Void)?, secondButtonAction: (() -> Void)?) {
        self.firstButtonTitle = firstButtonTitle
        self.secondButtonTitle = secondButtonTitle
        self.firstButtonAction = firstButtonAction
        self.secondButtonAction = secondButtonAction
        super.init(nibName: nil, bundle: nil)
        firstButton.setTitle(firstButtonTitle, for: .normal)
        secondButton.setTitle(secondButtonTitle, for: .normal)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init has not been implemented")
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        containerView.backgroundColor = ColorUtils.white
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.tintColor = ColorUtils.Olive
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.systemOrange
        titleLabel.font =  UIFont.FlatorySans.regular(18)
        titleLabel.tintColor = ColorUtils.mainGreen
        titleLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.font =  UIFont.FlatorySans.light(14)
        descriptionLabel.tintColor = ColorUtils.Olive
        
        configureButton(firstButton)
        configureButton(secondButton)
        
        firstButton.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
        
        containerView.addSubview(closeButton)
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(firstButton)
        containerView.addSubview(secondButton)
        
        view.addSubview(containerView)
    }
    
    private func configureButton(_ button: UIButton) {
        //button.backgroundColor = ColorUtils.white
        button.setTitleColor(ColorUtils.mainGreen, for: .normal)
        button.titleLabel?.font = UIFont.FlatorySans.bold(18)
        //button.layer.cornerRadius = 20
        //button.layer.borderColor = ColorUtils.secondaryGreen.cgColor
        //button.layer.borderWidth = 1.5
        button.clipsToBounds = true
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 1

    }
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 90),
            imageView.heightAnchor.constraint(equalToConstant: 90),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -70)
        ])
        
        if let _ = secondButtonTitle {
            secondButton.isHidden = false
            NSLayoutConstraint.activate([
                firstButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
                secondButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
                firstButton.heightAnchor.constraint(equalToConstant: 44),
                secondButton.heightAnchor.constraint(equalToConstant: 44),
                firstButton.widthAnchor.constraint(equalToConstant: 100),
                secondButton.widthAnchor.constraint(equalToConstant: 100),
                firstButton.leadingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: -110),
                secondButton.leadingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 10),
                secondButton.trailingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 110),
                firstButton.trailingAnchor.constraint(equalTo: secondButton.leadingAnchor, constant: -10)
            ])
        } else {
            secondButton.isHidden = true
            NSLayoutConstraint.activate([
                firstButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
                firstButton.heightAnchor.constraint(equalToConstant: 44),
                firstButton.widthAnchor.constraint(equalToConstant: 100),
                firstButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
        }
        
        containerView.layoutIfNeeded()
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func firstButtonTapped() {
        firstButtonAction?()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func secondButtonTapped() {
        secondButtonAction?()
        dismiss(animated: true, completion: nil)
    }
}
