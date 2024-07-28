//
//  HomeView.swift
//  StoriMovie
//
//  Created by MaurZac on 26/07/24.
//

import UIKit
import Combine

final class HomeView: UIViewController {
    
    private var viewModel: HomeViewModel!
    private var cancellables = Set<AnyCancellable>()
    private var lastContentOffset: CGFloat = 0
    
    private let searchBar = UISearchBar()
    private var tableView: UITableView!
    var coordinator: HomeViewCoordinator?
    private var viewControllerFactory: HomeViewControllerFactory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let repository = HomeViewRepositoryImp()
        let fetchMovieUseCase = HomeViewUseCase(repository: repository)
        viewModel = HomeViewModel(fetchMovieUseCase: fetchMovieUseCase)
        view.isUserInteractionEnabled = true
       
        setupUI()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let headerLabel = UILabel()
        headerLabel.text = "Las peliculas mas top"
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.FlatorySans.bold(20)
        headerLabel.textColor = ColorUtils.mainGreen
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerLabel)
        
        searchBar.delegate = self
        searchBar.placeholder = "Buscar..."
        searchBar.searchTextField.font = UIFont.FlatorySans.light(14)
        searchBar.tintColor = .systemBlue
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.alpha = 1
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.layer.borderColor = UIColor.white.cgColor
        searchBar.searchTextField.layer.borderWidth = 0
        searchBar.searchTextField.layer.cornerRadius = 20
        searchBar.barTintColor = UIColor.white
        searchBar.searchTextField.tintColor = UIColor.white
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.borderStyle = .roundedRect
        navigationItem.titleView = searchBar
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        view.addSubview(searchBar)
        
        let settingsButton = UIButton(type: .system)
        settingsButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        settingsButton.tintColor = .systemBlue
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.showsMenuAsPrimaryAction = true
        let profileAction = UIAction(title: "Perfil") { _ in
            
        }
        let nowPlaying = UIAction(title: "Mas Populares") { _ in
            
        }
        let logOut = UIAction(title: "Salir") { _ in
           
        }
        settingsButton.menu = UIMenu(title: "Opciones", children: [profileAction, nowPlaying, logOut])
        view.addSubview(settingsButton)
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -40),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            searchBar.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: -8),
            searchBar.trailingAnchor.constraint(equalTo: settingsButton.leadingAnchor, constant: 5),
            
            settingsButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            settingsButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 6),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.$filteredMovies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$searchText
            .sink { [weak self] searchText in
                self?.searchBar.text = searchText
            }
            .store(in: &cancellables)
    }
}

// MARK: - UISearchBarDelegate
extension HomeView: UISearchBarDelegate, UIScrollViewDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchMovies(with: searchBar.text ?? "")
        view.endEditing(true)
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.y
        view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource
extension HomeView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
          let movie = viewModel.filteredMovies[indexPath.row]

          viewModel.fetchImage(for: movie) { image in
              let formattedDate = self.viewModel.formatReleaseDate(movie.releaseDate)
              cell.configure(with: movie, image: image, formattedDate: formattedDate)
          }

          return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = viewModel.filteredMovies[indexPath.row]
        handleMovieSelection(selectedMovie)
    }
}

// MARK: - Movie Selection Handler
extension HomeView {
    
    func handleMovieSelection(_ movie: Movie) {
        coordinator?.navigateToMovieInfo(movie: movie)
    }
}
