//
//  PicsViewController.swift
//  Reddit Pics Browser
//
//  Created by AMAN JAIN on 26/06/22.
//

import UIKit

class PicsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var picsViewModel: PicsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Reddit Pics"
        setupViewModel()
    }
    
    func setupViewModel() {
        picsViewModel = PicsViewModel()
        picsViewModel?.reloadTableView =  { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        picsViewModel?.fetchPics()
    }
    
}

extension PicsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return picsViewModel?.pics?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PicsTableViewCell.self)", for: indexPath) as? PicsTableViewCell else {
            fatalError("Something wrong with cell.")
        }
        let pic = picsViewModel?.pics?[indexPath.row].data
        cell.configure(for: pic)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "\(PicsDetailViewController.self)") as? PicsDetailViewController else {return}
        viewController.picDetail = picsViewModel?.pics?[indexPath.row].data
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
