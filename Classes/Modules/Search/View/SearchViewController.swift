//
// Created by Damir Sitdikov on 15.08.2021.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    var output: SearchViewOutput!

    // MARK: - UI Components

    private(set) lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .init(origin: .zero, size: .init(width: view.bounds.width, height: 64)))
        searchBar.placeholder = "Search text..."
        searchBar.delegate = self
        return searchBar
    }()

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
//        tableView.dataSource = self
//        tableView.delegate = self
        tableView.register(SearchResultTableCell.self, forCellReuseIdentifier: SearchResultTableCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        return tableView
    }()

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Github.com"
        addSubviews()
        makeConstraints()
        output.viewDidLoad()
    }

    private func addSubviews() {
        view.addSubview(tableView)
        tableView.tableHeaderView = searchBar
    }

    private func makeConstraints() {
        tableView.snp.makeConstraints { maker in
            maker.top.leading.trailing.equalToSuperview()
            maker.bottom.equalTo(view.snp.bottomMargin)
        }
    }
}

// MARK: - SearchViewInput

extension SearchViewController: SearchViewInput {

}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("tableView(_:numberOfRowsInSection:) has not been implemented")
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("tableView(_:cellForRowAt:) has not been implemented")
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output.searchTextChanged(text: searchText)
    }
}
