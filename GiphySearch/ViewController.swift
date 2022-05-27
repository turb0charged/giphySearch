    //
    //  ViewController.swift
    //  GifSearch
    //
    //  Created by Hector Castillo on 5/26/22.
    //

import UIKit
import FLAnimatedImage

class GifSearchViewController: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    let navigationBar: UINavigationBar = {
        let navBar = UINavigationBar()
        navBar.isTranslucent = false
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()

    let gifNavigationItem: UINavigationItem = {
        let navigationItem = UINavigationItem()
        return navigationItem
    }()

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .systemBackground
        searchBar.placeholder = "Search for a gif"
        searchBar.searchBarStyle = .default
        return searchBar
    }()

    let viewModel: GifSearchViewModelType = GifSearchViewModel(networkingService: NetworkingService())


    override func viewDidLoad() {
        super.viewDidLoad()

            // Do any additional setup after loading the view.
        setup()
    }
    func setup() {
        view.addSubview(navigationBar)
        view.addSubview(tableView)
        gifNavigationItem.titleView = searchBar
        navigationBar.items = [gifNavigationItem]

        view.backgroundColor = .systemBackground

        viewModel.gifsLoaded = { [weak self] gifs in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),

            tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GifTableViewCell.self, forCellReuseIdentifier: "GifCell")
    }


}

extension GifSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.gifs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GifCell", for: indexPath) as? GifTableViewCell else {
            return UITableViewCell()
        }
        guard let url = URL(string: viewModel.gifs[indexPath.row].images.fixedHeightSmall.url) else {
            return cell
        }
        DispatchQueue.global().async {
            do {
                let gifData = try Data.init(contentsOf: url)
                DispatchQueue.main.async {
                    if let animatedImage = FLAnimatedImage(animatedGIFData: gifData) {
                        cell.gifImageView.animatedImage = animatedImage
                        tableView.beginUpdates()
                        tableView.endUpdates()
                    }
                }
            } catch let e {
                print(e.localizedDescription)
            }
        }
        cell.layoutIfNeeded()
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

extension GifSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchGifs(withSearchTerm: searchBar.text!)
        searchBar.searchTextField.resignFirstResponder()
    }
}
