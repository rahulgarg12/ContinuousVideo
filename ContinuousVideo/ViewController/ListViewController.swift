//
//  ListViewController.swift
//  ContinuousVideo
//
//  Created by Rahul Garg on 12/11/20.
//

import UIKit

final class ListViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = .secondarySystemBackground
            tableView.tableFooterView = nil
            tableView.separatorStyle = .none
            tableView.showsVerticalScrollIndicator = false
            tableView.contentInset = UIEdgeInsets(top: 0,
                                                  left: 0,
                                                  bottom: Constants.Space.imageCarouselBottomInset,
                                                  right: 0)
            tableView.register(cellType: ListViewCollectionTableCell.self)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    
    // MARK: Properties
    private var viewModel = ListViewModel()

    
    // MARK: Overridden Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        getJSONData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    // MARK: - Private Helpers
    private func initNavigationBar() {
        title = Constants.Title.listViewContollerTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func getJSONData() {
        viewModel.getJSONData { (error) in
            if error == nil {
                tableView.reloadData()
            }
        }
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 60)
        headerView.backgroundColor = .secondarySystemBackground
        
        let heading = UILabel()
        heading.frame = CGRect(x: 20, y: 30, width: headerView.bounds.width-40, height: 20)
        heading.font = .sectionHeader
        heading.textColor = .label
        heading.text = viewModel.getHeading(at: section)
        headerView.addSubview(heading)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Space.imageCarouselHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.getCell(tableView, at: indexPath)
        cell.delegate = self
        return cell
    }
}


// MARK: - ListViewCollectionTableCellDelegate
extension ListViewController: ListViewCollectionTableCellDelegate {
    func didTapCollectionVideo(at indexPath: IndexPath, nodes: [NodeModel]?) {
        let vc = PlayerViewController.loadFromNib()
        vc.viewModel = PlayerViewModel(nodes: nodes, currentItem: indexPath.item)
        navigationController?.pushViewController(vc, animated: true)
    }
}
