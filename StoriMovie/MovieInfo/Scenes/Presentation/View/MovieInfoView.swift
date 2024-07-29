//
//  MovieInfoView.swift
//  StoriMovie
//
//  Created by MaurZac on 26/07/24.
//

import UIKit
import Combine

final class MovieInfoView: UIViewController, UIScrollViewDelegate {
    
    var viewModel: MovieInfoViewModel
    var coordinator: HomeTabBarCoordinator
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: MovieInfoViewModel, coordinator:HomeTabBarCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        button.setImage(UIImage(systemName: "chevron.left.circle.fill", withConfiguration: configuration), for: .normal)
        button.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = ColorUtils.OliveThree
        return button
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        let configuration = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        let favoriteImage = UIImage(systemName: "heart", withConfiguration: configuration)
        button.setImage(favoriteImage, for: .normal)
        button.setTitle("   Agregar a mis favoritos", for: .normal)
        button.titleLabel?.font = UIFont.FlatorySans.regular(18)
        button.setTitleColor(ColorUtils.secondaryGreen, for: .normal)
        button.tintColor = ColorUtils.secondaryGreen
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = ColorUtils.secondaryGreen.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        return button
    }()
    
    @objc private func addToFavorites() {
        print("Agregar a mis favoritos")
        self.coordinator.presentCustomAlert(image: UIImage(systemName: "heart"), title: "Agregar a Favortios", description: "¿Deseas agregar esta pelicula a tu seccion de favoritos?", firstButtonTitle: "Agregar", secondButtonTitle: "Cancelar", firstButtonAction: {
            self.viewModel.addMovieToFavorites()
        }, secondButtonAction: {})
    }
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.FlatorySans.bold(16)
        label.numberOfLines = 0
        label.tintColor = ColorUtils.mainGreen
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.FlatorySans.regular(12)
        label.numberOfLines = 0
        label.tintColor = ColorUtils.Olive
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let popularity: UILabel = {
        let label = UILabel()
        label.font = UIFont.FlatorySans.regular(12)
        label.numberOfLines = 0
        label.tintColor = ColorUtils.Olive
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.FlatorySans.regular(14)
        label.tintColor = ColorUtils.secondaryGreen
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        self.navigationController?.navigationBar.isHidden = true
//    }
    
    private func setupUI() {
        view.backgroundColor = ColorUtils.lightGray

        // Add scrollView and contentView to the main view
        view.addSubview(scrollView)
        view.addSubview(imageView) // ImageView está fuera del scrollView
        scrollView.addSubview(contentView)

        // Add subviews to contentView
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieDescriptionLabel)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(dateLabel)
        contentView.addSubview(popularity)

        // Add backButton last so it stays on top
        view.addSubview(backButton)

        // Configure favoriteButton
        favoriteButton.titleLabel?.lineBreakMode = .byTruncatingTail // Permite truncar el texto si es muy largo
        favoriteButton.titleLabel?.adjustsFontSizeToFitWidth = true // Ajusta el tamaño de la fuente para que se ajuste al ancho del botón
        favoriteButton.titleLabel?.minimumScaleFactor = 0.5 // Escala mínima de la fuente
        favoriteButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16) // Añade espacio alrededor del texto

        // Setup constraints
        NSLayoutConstraint.activate([
            // ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor), // Asegura que el scrollView esté justo debajo de la imageView
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // ContentView constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // ImageView constraints
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),

            // BackButton constraints
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
            backButton.heightAnchor.constraint(equalToConstant: 60),
            backButton.widthAnchor.constraint(equalToConstant: 60),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),

            // MovieTitleLabel constraints
            movieTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            movieTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            // DateLabel constraints
            dateLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -6),
            
            // Popularity constraints
            popularity.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 4),
            popularity.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 6),
            popularity.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            // MovieDescriptionLabel constraints
            movieDescriptionLabel.topAnchor.constraint(equalTo: popularity.bottomAnchor, constant: 12),
            movieDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            movieDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            // FavoriteButton constraints
            favoriteButton.topAnchor.constraint(equalTo: movieDescriptionLabel.bottomAnchor, constant: 60),
            favoriteButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            favoriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50), // Ajusta la altura si es necesario
            favoriteButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 200) // Ajusta el ancho si es necesario
        ])
        
        // Update the contentView's bottom constraint to ensure scrolling
        contentView.bottomAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 20).isActive = true

        // Bring backButton to front to ensure it's above all other views
        view.bringSubviewToFront(backButton)
    }





    
    private func setupBindings() {
        viewModel.$posterImage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.imageView.image = image
            }
            .store(in: &cancellables)
        
        viewModel.$movieTitle
            .receive(on: DispatchQueue.main)
            .sink { [weak self] name in
                self?.movieTitleLabel.text = name
            }
            .store(in: &cancellables)
        
        viewModel.$overview
            .receive(on: DispatchQueue.main)
            .sink { [weak self] description in
                self?.movieDescriptionLabel.text = description
            }
            .store(in: &cancellables)
        
        viewModel.$popularity
            .receive(on: DispatchQueue.main)
            .sink { [weak self] popularity in
                self?.popularity.text = "🏆 Popularidad: \(popularity)"
            }
            .store(in: &cancellables)
        
        viewModel.$releaseDate
            .receive(on: DispatchQueue.main)
            .sink { [weak self] date in
                self?.dateLabel.text = "🗓️ \(DateUtils.formatReleaseDate(date).capitalized)"
            }
            .store(in: &cancellables)
    }
    
    
    @objc private func popViewController() {
        navigationController?.popViewController(animated: true)
    }
   
}

