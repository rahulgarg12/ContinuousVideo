//
//  ListViewModel.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 12/11/20.
//

import UIKit

final class ListViewModel {
    // MARK: Properties
    private var dataModel = [DataModel]()
    
    // MARK: Computed Properties
    var sectionCount: Int {
        return dataModel.count
    }
    
    
    // MARK: Helpers
    func getJSONData(completion: (CVError?) -> ()) {
        if let path = Bundle.main.path(forResource: "assignment", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let responseModel = try JSONDecoder().decode([DataModel].self, from: data)
                dataModel = responseModel
            } catch {
                completion(.error(error))
            }
        } else {
            completion(.jsonFileNotFound)
        }
    }
    
    
    // MARK: Table Helpers
    func getHeading(at section: Int) -> String {
        return dataModel[section].title
    }
    
    func getCell(_ tableView: UITableView, at indexPath: IndexPath) -> ListViewCollectionTableCell {
        let cell = tableView.dequeueReusableCell(with: ListViewCollectionTableCell.self, for: indexPath)
        if dataModel.count > indexPath.row {
            let listCellViewModel = ListViewCollectionTableCellViewModel(nodes: dataModel[indexPath.section].nodes)
            cell.viewModel = listCellViewModel
        }
        return cell
    }
}
