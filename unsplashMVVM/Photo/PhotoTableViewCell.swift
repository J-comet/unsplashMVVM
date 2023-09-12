//
//  CustomTableViewCell.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/12.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet var thumbImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbImageView.layer.cornerRadius = 8
        thumbImageView.clipsToBounds = true
        thumbImageView.contentMode = .scaleToFill
    }

    func configureCell(row: String) {
        let thumb = URL(string: row)
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: thumb!)
            DispatchQueue.main.async { [weak self] in
                self?.thumbImageView.image = UIImage(data: data)
            }
        }
    }
}
