  //
//  ViewController.swift
//  week4
//
//  Created by Ali serkan Boyracı  on 29.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var tcNoTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
       // tcNoTextField.delegate = self
        tcNoTextField.addTarget(self, action: #selector(didTextFieldChange), for: .editingChanged)
        // every editing time, enter selector func and print.
    }

    @IBAction func nextButtonClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "TableViewController") as? TableViewController {
            vc.modalPresentationStyle = .fullScreen // to see full screen TableViewVC
            present(vc, animated: true)
        }
        
        let tcNo = tcNoTextField.text!
        contentTitleLabel.text = tcNo
    }
    
    @objc func didTextFieldChange() {
        print("\(tcNoTextField.text!)") // to prevent optional you can put ! or  ?? ""
        contentTitleLabel.text = tcNoTextField.text // you can see the text at the label instantly
        
    }
    
}


/* extension ViewController: UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == "ç" { // you can write but you cant see.
            return false
        }
        print("\(textField.text ?? "")")
        
        return true
    }
}
*/
