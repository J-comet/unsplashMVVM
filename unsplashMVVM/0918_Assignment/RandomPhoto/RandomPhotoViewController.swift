//
//  RandomPhotoViewController.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/18.
//

import UIKit
import SnapKit

class RandomPhotoViewController: UIViewController {
    
    private let viewModel = RandomPhotoViewModel()
    
    private let imageView = UIImageView(frame: .zero)
    
    private let randomButton = {
        let view = UIButton()
        var attString = AttributedString("랜덤 이미지")
        attString.font = .systemFont(ofSize: 14, weight: .medium)
        attString.foregroundColor = .white
        var config = UIButton.Configuration.filled()
        config.attributedTitle = attString
        config.baseBackgroundColor = .systemBlue
        view.configuration = config
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindData()
        viewModel.getRandomPhoto()
        
        randomButton.addTarget(self, action: #selector(randomButtonClicked), for: .touchUpInside)
    }
    
    @objc func randomButtonClicked() {
        imageView.image = nil
        viewModel.getRandomPhoto()
    }
    
    private func bindData() {
        viewModel.randomPhoto.bind { [weak self] photo in
            guard let photo else { return }
            let thumb = URL(string: photo.urls.full)
            DispatchQueue.global().async {
                let data = try! Data(contentsOf: thumb!)
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    private func configureView() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalTo(150)
            make.center.equalToSuperview()
        }
        
        view.addSubview(randomButton)
        randomButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.width.equalTo(200)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
    }
}
