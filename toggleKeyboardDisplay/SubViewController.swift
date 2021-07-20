//
//  SubViewController.swift
//  toggleKeyboardDisplay
//
//  Created by 佐藤瑠偉史 on 2021/07/19.
//

import UIKit

class SubViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var btnStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        imageView.isHidden = true
        

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let info = notification.userInfo!
        let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//        let topStackView = btnStackView.frame.origin.y
//        btnStackView.frame.origin.y = topStackView - keyboardFrame.height
        let btnStackViewHeght = btnStackView.frame.height
        if btnStackView.frame.origin.y != keyboardFrame.origin.y - btnStackViewHeght {
            btnStackView.frame.origin.y = keyboardFrame.origin.y - btnStackViewHeght
        }
        print("キーボード表示： \(keyboardFrame)")
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        let info = notification.userInfo!
        let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let btnStackViewHeight = btnStackView.frame.height
        btnStackView.frame.origin.y = keyboardFrame.origin.y - btnStackViewHeight
        print("キーボード非表示： \(keyboardFrame)")
    }

}
