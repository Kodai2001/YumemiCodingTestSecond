//
//  ViewController.swift
//  YumemiCodingTest
//
//  Created by system on 2021/10/25.
//

import UIKit

class ViewController: UIViewController {
    var items: [Repository.Item] = []
    var task: URLSessionTask?
    
    var textUserInput: String?
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .secondarySystemBackground
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        
        navigationController?.navigationBar.topItem?.titleView = searchBar
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
}

//MARK: - searchBar

extension ViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        textUserInput = searchBar.text
        searchBar.resignFirstResponder()
        guard let textUserInput = textUserInput else {
            return
        }
        if textUserInput.count != 0 {
            Github.getTableItems(with: textUserInput) { items in
                self.items = items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
   
}

//MARK: - tableView

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let repository = repositories[indexPath.row]
        //cell.textLabel?.text = data["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository.language as? String ?? ""
        cell.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = ResultViewController()
        
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.navigationItem.title = "Result"
        
        let repository = repositories[indexPath.row]
        print(repository.language)
        // ResultVCに値を渡す
        vc.indexPathRow = indexPath.row
        vc.repositories = repositories
        navigationController?.pushViewController(vc, animated: true)
    }
}


