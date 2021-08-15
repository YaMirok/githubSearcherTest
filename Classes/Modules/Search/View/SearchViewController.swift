//
// Created by Damir Sitdikov on 15.08.2021.
//

import UIKit
import SnapKit

private extension SearchViewController {
    enum CellType {
        case resultItem(model: SearchResultTableCellModel)
    }
}

final class SearchViewController: UIViewController {
    var output: SearchViewOutput!

    // MARK: - Variables

    private var cellsModels = [CellType]()

    // MARK: - UI Components

    private(set) lazy var networkActivityIndicator: HorizontalAnimationView = {
        let view = HorizontalAnimationView()
        return view
    }()

    private(set) lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .init(origin: .zero, size: .init(width: view.bounds.width, height: 64)))
        searchBar.placeholder = "Search text..."
        searchBar.delegate = self
        return searchBar
    }()

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchResultTableCell.self, forCellReuseIdentifier: SearchResultTableCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        return tableView
    }()

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Themed.white
        title = "Github.com"
        addSubviews()
        makeConstraints()
        output.viewDidLoad()
    }

    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(networkActivityIndicator)
        tableView.tableHeaderView = searchBar
    }

    private func makeConstraints() {
        networkActivityIndicator.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(view.snp.topMargin)
            maker.height.equalTo(4)
        }
        tableView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(view.snp.topMargin)
            maker.bottom.equalTo(view.snp.bottomMargin)
        }
    }
}

// MARK: - SearchViewInput

extension SearchViewController: SearchViewInput {

    func showLoadingAnimation() {
        networkActivityIndicator.startAnimation()
    }

    func hideLoadingAnimation() {
        networkActivityIndicator.stopAnimation()
    }

    func showNewItems(_ items: [SearchResultTableCellModel]) {
        cellsModels = items.map { .resultItem(model: $0) }
        tableView.reloadData()
    }

    func appendItems(_ items: [SearchResultTableCellModel]) {
        let startIndex = cellsModels.count
        cellsModels.append(contentsOf: items.map { .resultItem(model: $0) })
        let endIndex = cellsModels.count
        let indexPathsToInsert = (startIndex..<endIndex).map { IndexPath(row: $0, section: 0)}
        tableView.performBatchUpdates {
            tableView.insertRows(at: indexPathsToInsert, with: .bottom)
        }
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellsModels.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cellsModels[indexPath.row]
        switch cellModel {
        case let .resultItem(model):
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableCell.reuseIdentifier, for: indexPath) as! SearchResultTableCell
            cell.configure(model)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let loadMoreIndex = cellsModels.count - 5
        guard indexPath.row == loadMoreIndex else { return }
        output.loadMoreIndexWillShow()
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellModel = cellsModels[indexPath.row]
        switch cellModel {
        case let .resultItem(model):
            output.showDetailsPageForRepo(on: model.url)
        }
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output.searchTextChanged(text: searchText)
    }

}
