//
//  AddTodoViewController.swift
//  hello
//
//  Created by Woo0 on 2021/02/02.
//

import UIKit

class AddTodoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTextView.layer.borderColor = UIColor.gray.cgColor
        contentTextView.layer.borderWidth = 0.3
        contentTextView.layer.cornerRadius = 2.0
        contentTextView.clipsToBounds = true

    }
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func doneBtn(_ sender: Any) {
        let title = titleTextField.text!
        let content = contentTextView.text ?? ""
        
        let item: TodoList = TodoList(title: title, content: content)
        
        print("Add List title : \(item.title)")
        list.append(item)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
