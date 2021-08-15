//
// Created by Damir Sitdikov on 15.08.2021.
//

import Foundation

protocol SearchViewOutput {
    func viewDidLoad()
    func searchTextChanged(text: String)
    func loadMoreIndexWillShow()
    func showDetailsPageForRepo(on url: URL)
}
