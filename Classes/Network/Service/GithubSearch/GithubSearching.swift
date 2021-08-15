//
// Created by Damir Sitdikov on 15.08.2021.
//

import Foundation

protocol GithubSearching {
    func search(text: String,
                page: Int,
                pageSize: Int,
                completion: @escaping (_ result: Result<SearchResultResponse, Error>) -> Void) -> Cancellable?
}
