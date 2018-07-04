import UIKit

struct MLModelListViewBuilder {
    static func build() -> UINavigationController {
        let mlModelListViewController: MLModelListViewController = .init()
        return .init(rootViewController: mlModelListViewController)
    }
}
