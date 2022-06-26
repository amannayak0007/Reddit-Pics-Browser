//
//  PicsViewModel.swift
//  Reddit Pics Browser
//
//  Created by AMAN JAIN on 26/06/22.
//

import Foundation

class PicsViewModel {
    
    var pics: [Child]? {
        didSet {
            reloadTableView?()
        }
    }
    var reloadTableView: (() -> Void)?
    var networkManager = NetworkManager()
    
    func fetchPics() {
        guard let url = URL(string: "http://www.reddit.com/r/pics/.json?jsonp=") else {
            fatalError("Invalid URL")
        }
        networkManager.request(fromURL: url) { (result: Result<Pic, Error>) in
            switch result {
            case .success(let pic):
                self.pics = pic.data.children.sorted{$0.data.created > $1.data.created}
            case .failure(let error):
                debugPrint("We got a failure error : \(error.localizedDescription)")
            }
        }
    }
}
