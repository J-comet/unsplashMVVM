//
//  ViewController.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var changeButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nicknameTextField.placeholder = "nickname_placeholder".localized
        
        //MARK: %@ -> String 
//        let value = NSLocalizedString("nickname_result", comment: "")
//        resultLabel.text = String(format: value, "고래밥", "상어", "라면")
        
        resultLabel.text = "age_result".localized(number: 3)
        
        // cmd ctrl e
        let searchBar = UISearchBar()
        searchBar.text = "asd"
        searchBar.placeholder = "sds"
        searchBar.searchTextField.text = "sdsd"
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)        // Ctrl + Shift + 클릭 => 동시에 입력
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)        // Ctrl + Shift + 클릭 => 동시에 입력
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)        // Ctrl + Shift + 클릭 => 동시에 입력
    }
}

