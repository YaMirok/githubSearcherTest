//
// Created by Damir Sitdikov on 15.08.2021.
//

import Alamofire

protocol Cancellable {
    func cancel()
}

extension DataRequest: Cancellable {
    func cancel() {
        super.cancel()
    }
}
