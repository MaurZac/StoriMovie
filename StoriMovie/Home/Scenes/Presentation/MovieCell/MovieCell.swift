//
//  MovieViewTableViewCell.swift
//  StoriMovie
//
//  Created by MaurZac on 27/07/24.
//

import UIKit

class MovieCell: UITableViewCell {
    let movieImageView = UIImageView()
    var movieTitleLabel = UILabel()
    var dateReleaseLabel = UILabel()
    let movieOptionsBtn = UIButton()
    let separatorLine = UIView()
    var onShare: (() -> Void)?
    var onAddFavorites: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
        movieImageView.layer.cornerRadius = 10
        movieImageView.layer.masksToBounds = true
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieImageView)
        
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        movieTitleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        movieTitleLabel.font = UIFont.FlatorySans.regular(16)
        movieTitleLabel.textColor = ColorUtils.secondaryGreen
        contentView.addSubview(movieTitleLabel)
        
        dateReleaseLabel.translatesAutoresizingMaskIntoConstraints = false
        dateReleaseLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        dateReleaseLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        dateReleaseLabel.font = UIFont.FlatorySans.light(12)
        dateReleaseLabel.textColor = ColorUtils.OliveTwo
        contentView.addSubview(dateReleaseLabel)
        
        movieOptionsBtn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        movieOptionsBtn.translatesAutoresizingMaskIntoConstraints = false
        movieOptionsBtn.tintColor = ColorUtils.mainGreen
        movieOptionsBtn.showsMenuAsPrimaryAction = true
        let shareMovie = UIAction(title: "Compartir", image: UIImage(systemName: "square.and.arrow.up")) { _ in
            self.onShare?()
        }
        let addFavorites = UIAction(title: "Agregar a Favoritos", image: UIImage(systemName: "heart")) { _ in
            self.onAddFavorites?()
        }
        movieOptionsBtn.menu = UIMenu(title: "", children: [shareMovie, addFavorites])
        contentView.addSubview(movieOptionsBtn)
        
        separatorLine.backgroundColor = ColorUtils.GrayGreenTwo
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separatorLine)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            movieImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            movieImageView.widthAnchor.constraint(equalToConstant: 140),
            movieImageView.heightAnchor.constraint(equalToConstant: 80),
            
            movieOptionsBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            movieOptionsBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieOptionsBtn.widthAnchor.constraint(equalToConstant: 30),
            movieOptionsBtn.heightAnchor.constraint(equalToConstant: 30),
            
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            movieTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            movieTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: movieOptionsBtn.leadingAnchor, constant: -10),
            
            dateReleaseLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            dateReleaseLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 5),
            dateReleaseLabel.trailingAnchor.constraint(lessThanOrEqualTo: movieOptionsBtn.leadingAnchor, constant: -10),
            
            separatorLine.leadingAnchor.constraint(equalTo: dateReleaseLabel.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            separatorLine.topAnchor.constraint(equalTo: dateReleaseLabel.bottomAnchor, constant: 5),
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        movieImageView.image = nil
    }
    
    func configure(with movie: Movie, image: UIImage?, formattedDate: String) {
        movieTitleLabel.text = movie.title
        dateReleaseLabel.text = formattedDate
        movieImageView.image = image
    }
    
}
