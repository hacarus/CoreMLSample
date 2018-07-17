import UIKit
import CoreML

struct CaptureViewBuilder {
    static func build(for mlModel: MLModel) -> CaptureViewController {
        let viewController: CaptureViewController = .init()
        let viewModel = CaptureViewModel(mlModel: mlModel)
        
        viewController.inject(viewModel)
        
        return viewController
    }
}
