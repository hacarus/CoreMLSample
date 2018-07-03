import UIKit

// You can customize your own ML Model.
// You can just add item. Below is esample.
// .init(title: "section title", items: ["This item is define in MLModels"])

struct MLModelListViewModel {
    let sections: [Section] = [
                                .init(title: "Provided by Apple Inc.", items: [.mobileNet]),
                                .init(title: "Provided by my self", items: [.squeezeNet]),
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
        }
    }
}
