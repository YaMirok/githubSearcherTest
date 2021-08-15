//
// Created by Damir Sitdikov on 25.05.2021.
//

import Foundation
import Alamofire

extension Encodable {
    func toParameters() -> Parameters? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        do {
            let result = ((try JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any])
            return result
        } catch {
            assertionFailure(error.localizedDescription)
            return nil
        }
    }
}