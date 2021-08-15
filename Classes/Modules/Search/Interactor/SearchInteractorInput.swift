//
// Created by Damir Sitdikov on 15.08.2021.
//

import Foundation

protocol SearchInteractorInput {
    func obtainSearchResults(for text: String)
    func loadNextResultsPage(for text: String)
}
