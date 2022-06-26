//
//  PicsDetailViewController.swift
//  Reddit Pics Browser
//
//  Created by AMAN JAIN on 26/06/22.
//

import UIKit

class PicsDetailViewController: UIViewController {
    
    @IBOutlet private weak var picImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var favouriteButton: UIButton!
    
    var picDetail: ChildData?
    var favouritePic: FavoritePics?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        if favouritePic != nil {
            picDetail = ChildData(title: favouritePic?.title ?? "",
                                  created: favouritePic?.created ?? 0,
                                  author: favouritePic?.author ?? "",
                                  url: favouritePic?.url ?? "",
                                  isFavourite: true)
        }
        titleLabel.text = picDetail?.title
        dateLabel.text = picDetail?.created.getDate()
        authorLabel.text = "Author: \(picDetail?.author ?? "")"
        if let imageUrl = picDetail?.url {
            picImageView.loadImage(withUrl: imageUrl)
        } else {
            picImageView.image = nil
        }
        setupFavouriteButton()
    }
    
    func setupFavouriteButton() {
        if picDetail?.isFavourite ?? false {
            favouriteButton.setTitle("Remove from Favourite", for: .normal)
            favouriteButton.setTitleColor(.white, for: .normal)
            favouriteButton.backgroundColor = .systemBlue
            favouriteButton.layer.cornerRadius = favouriteButton.frame.height/2
            favouriteButton.addTarget(self, action: #selector(addOrRemoveFavourite), for: .touchUpInside)
        } else {
            favouriteButton.setTitle("Add to Favourite", for: .normal)
            favouriteButton.setTitleColor(.systemBlue, for: .normal)
            favouriteButton.backgroundColor = .clear
            favouriteButton.layer.cornerRadius = favouriteButton.frame.height/2
            favouriteButton.layer.borderWidth = 1
            favouriteButton.layer.borderColor = UIColor.systemBlue.cgColor
            favouriteButton.addTarget(self, action: #selector(addOrRemoveFavourite), for: .touchUpInside)
        }
    }
    
    @objc func addOrRemoveFavourite() {
        if picDetail?.isFavourite ?? false, let favouritePic = favouritePic {
            PersistentStorage.shared.context.delete(favouritePic)
            PersistentStorage.shared.saveContext()
            navigationController?.popViewController(animated: true)
        } else {
            favouritePic = FavoritePics(context: PersistentStorage.shared.context)
            favouritePic?.title = picDetail?.title
            favouritePic?.author = picDetail?.author
            favouritePic?.created = picDetail?.created ?? 0
            favouritePic?.url = picDetail?.url
            PersistentStorage.shared.saveContext()
        }
        setupView()
    }

}
