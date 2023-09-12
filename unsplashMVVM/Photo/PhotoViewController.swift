//
//  PhotoViewController.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/12.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet var photoTableView: UITableView!
    
    private let viewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchPhoto()
        
        viewModel.list.bind { _ in
            DispatchQueue.main.async {
                self.photoTableView.reloadData()
            }
        }
        
        photoTableView.dataSource = self
        photoTableView.delegate = self
        photoTableView.rowHeight = 100
    }

}

extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell") as! PhotoTableViewCell
        let data = viewModel.cellForRowAt(at: indexPath)
        cell.backgroundColor = .lightGray
        cell.configureCell(row: data.urls.thumb)
        return cell
    }
    
    
}
