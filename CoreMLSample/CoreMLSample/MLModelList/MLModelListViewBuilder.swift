import UIKit

struct MLModelListViewBuilder {
    static func build() -> UINavigationController {
        return .init(rootViewController: MLModelListViewController())
    }
}
