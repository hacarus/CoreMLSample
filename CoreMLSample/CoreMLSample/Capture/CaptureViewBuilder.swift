import UIKit
import CoreML

struct CaptureViewBuilder {
    static func build(for mlModel: MLModel) -> CaptureViewController {
        let viewModel = CaptureViewModel(mlModel: mlModel)
         let viewController: CaptureViewController = .init(viewModel)
        
        return viewController
    }
}
