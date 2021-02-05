//
//  ViewController.swift
//  hello
//
//  Created by Woo0 on 2021/01/22.
//

import UIKit

var list = [TodoList] ()

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
        
        list.append(TodoList(title: "test1", content:   "testData1"))
        list.append(TodoList(title: "test2", content: "testData2"))
        list.append(TodoList(title: "test3", content: "testData3"))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
     
      cell.textLabel?.text = list[indexPath.row].title
      cell.detailTextLabel?.text = list[indexPath.row].content
      if list[indexPath.row].isComplete {
        cell.accessoryType = .checkmark
      }else{
        cell.accessoryType = .none
      }
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            list.remove(at: indexPath.row)
            todoListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // 이미 체크되있는 경우 return
            guard !list[indexPath.row].isComplete else {
                return
            }
     
            // 리스트 선택 시 완료된 할일 표시(checkmark)
            list[indexPath.row].isComplete = true
     
            let dialog = UIAlertController(title: "Todo List", message: "일을 완료했습니다!!!!!", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
            dialog.addAction(action)
            self.present(dialog, animated: true, completion: nil)
     
            todoListTableView.reloadData()
        }
    
    @IBOutlet weak var todoListTableView: UITableView!

    @IBAction func EditBtn(_ sender: Any) {
        guard !list.isEmpty else {
                    return
        }
        if todoListTableView.isEditing {
            todoListTableView.setEditing(false, animated: true)
        } else {
            todoListTableView.setEditing(true, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        todoListTableView.reloadData()
    }
}
