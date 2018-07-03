import UIKit
import CoreML
import Vision

final class MLModelListViewController: UITableViewController {
    // You can customize your own ML Model.
    // You can just add item. Below is esample.
    // .init(title: "section title", items: ["This item is define in MLModelListViewModel.Section.MLModels"])
    
    private let viewModel = MLModelListViewModel(sections: [
                                                            .init(title: "Provided by Apple Inc.", items: [.mobileNet]),
                                                            .init(title: "Provided by my self", items: [.squeezeNet]),
                                                            ])
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose ML Models"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].title
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.sections[indexPath.section].items[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var model: MLModel
        switch viewModel.sections[indexPath.section].items[indexPath.row] {
        case .mobileNet:
            model = MobileNet().model
        case .squeezeNet:
            model = SqueezeNet().model
        }
        
        let targetView = AVCaptureViewBuilder.build(for: model)
        navigationController?.pushViewController(targetView, animated: true)
    }
}
