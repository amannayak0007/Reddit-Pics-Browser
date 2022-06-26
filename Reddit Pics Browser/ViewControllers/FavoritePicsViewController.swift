//
//  FavoritePicsViewController.swift
//  Reddit Pics Browser
//
//  Created by AMAN JAIN on 26/06/22.
//

import UIKit
import CoreData

class FavoritePicsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<FavoritePics> = {
        let fetchRequest: NSFetchRequest<FavoritePics> = FavoritePics.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "created", ascending: false)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: PersistentStorage.shared.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Favourite Pics"
        fetchFavouritePics()
    }
    
    func fetchFavouritePics() {
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }

}

extension FavoritePicsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let favouritePics = fetchedResultsController.fetchedObjects else { return 0 }
        return favouritePics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PicsTableViewCell.self)", for: indexPath) as? PicsTableViewCell else {
            fatalError("Something wrong with cell.")
        }
        let pic = fetchedResultsController.object(at: indexPath)
        cell.configure(for: pic)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "\(PicsDetailViewController.self)") as? PicsDetailViewController else {return}
        viewController.favouritePic = fetchedResultsController.object(at: indexPath)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension FavoritePicsViewController: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        default:
            print("...")
        }
    }
    
}
