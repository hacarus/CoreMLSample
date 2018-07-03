import UIKit

struct MLModelListViewModel {
    let sections: [Section]
    
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
