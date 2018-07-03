import UIKit
import CoreML

struct AVCaptureViewBuilder {
    static func build(for mlModel: MLModel) -> AVCaptureViewController {
        let viewController: AVCaptureViewController = .init()
        let viewModel = AVCaptureViewModel(mlModel: mlModel)
        
        viewController.inject(viewModel)
        
        return viewController
    }
}
