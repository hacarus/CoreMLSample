import UIKit
import CoreML
import Vision

// You can customize your own ML Model.
// You can just add item. Below is exsample.
// .init(title: "section title", items: ["Item is MLModel that define MLModels of enum case"])

struct MLModelListViewModel {
    let sections: [Section] = [
                                .init(title: "Provided by Apple Inc.", items: [.mobileNet]), // Add in array of items provided by apple.
                                .init(title: "Provided by own", items: [.squeezeNet]), // Add in array of items created by own.
                              ]
    
    struct Section {
        let title: String
        let items: [MLModels]
        
        enum MLModels {
            case mobileNet
            case squeezeNet
            
            var title: String {
                switch self {
                case .mobileNet:
                    return "Mobile Net"
                case .squeezeNet:
                    return "Squeeze Net"
                }
            }
            
            var model: MLModel {
                switch self {
                case .mobileNet:
                    return MobileNet().model
                case .squeezeNet:
                    return SqueezeNet().model
                }
            }
        }
    }
}
