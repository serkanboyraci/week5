  //
//  ViewController.swift
//  week4
//
//  Created by Ali serkan Boyracı  on 29.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // tcNoTextField.delegate = self
        //tcNoTextField.addTarget(self, action: #selector(didTextFieldChange), for: .editingChanged)
        // every editing time, enter selector func and print.
        // }
    }
        
    @IBAction func nextButtonClicked(_ sender: Any) {
            
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            //if let vc = storyBoard.instantiateViewController(withIdentifier: "TableViewController") as? TableViewController {
            if let vc = storyBoard.instantiateViewController(withIdentifier: "CollectionViewController") as? CollectionViewController {
                vc.modalPresentationStyle = .fullScreen // to see full screen TableViewVC
                present(vc, animated: true)
            }
    }
    
}
