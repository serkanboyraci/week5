  //
//  ViewController.swift
//  week4
//
//  Created by Ali serkan Boyracı  on 29.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.addTarget(self, action: #selector(didTextChange), for: .editingChanged)
        textField.text = UserDefaults.standard.string(forKey: "mainScreenTextFieldValue") // save for this key.
    }
    
    @objc private func didTextChange() {
        let text = textField.text
        UserDefaults.standard.set(text, forKey: "mainScreenTextFieldValue") // keep value with key, like dicts. // you cant use this key-value pari immediately. you must wait a bit.
        //UserDefaults.standard.synchronize() // to save the words, dont need any more
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
