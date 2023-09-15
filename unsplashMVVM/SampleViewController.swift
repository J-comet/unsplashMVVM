//
//  SampleViewController.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/12.
//

import UIKit

class SampleViewController: UIViewController {

    @IBOutlet var userTableView: UITableView!
    
    private let viewModel = SampleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        var number1 = 10
        var number2 = 3
        print(number1 - number2)
        
        number2 = 3
        number1 = 1
        
        
        // 양방향데이터바인딩
        var number3 = Observable(10)
        var number4 = Observable(3)
        
        number3.bind { num in
            print("Observable", number3.value - number4.value)
        }
        
        number3.value = 300
        number3.value = 200
        
        userTableView.dataSource = self
        userTableView.delegate = self
    }

}

extension SampleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell")!
//        let data = viewModel.cellForRowAt(at: indexPath)
//        cell.textLabel?.text = data.introduce
        
        let cell = UITableViewCell()
        
        var content = cell.defaultContentConfiguration()
        content.text = "테스트"                                 // <= cell.textLabel == deprecated
        content.secondaryText = "안녕하세요 \(indexPath.row)"      // <= cell.detailTextLabel
        cell.contentConfiguration = content                    // Protocl as Type
        
        return cell
    }
    
}
