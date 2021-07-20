//
//  ViewController.swift
//  toggleKeyboardDisplay
//
//  Created by 佐藤瑠偉史 on 2021/07/19.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var isObserving = false
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var messageSenderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (!isObserving) {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            isObserving = true
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (isObserving) {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
            isObserving = false
        }
    }
    
    
    @objc func keyboardWillShow(notification: Notification) {
        // キーボードのフレーム値を取得
        let rect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        // キーボードのアニメーションの時間を取得
        let duration:TimeInterval? = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        if let rect = rect, let duration = duration {
            UIView.animate(withDuration: duration) {
                let transform = CGAffineTransform(translationX: 0, y: -rect.size.height)
                self.messageSenderView.transform = transform
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double)
        if let duration = duration {
            UIView.animate(withDuration: duration) {
                self.messageSenderView.transform = CGAffineTransform.identity
            }
        }
    }
    @IBAction func sendAction(_ sender: UIButton) {
        textView.resignFirstResponder()
    }
}

