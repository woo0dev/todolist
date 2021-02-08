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
        
        loadAllData()
        print(list.description)
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
        saveAllData()
        todoListTableView.reloadData()
    }
    
    func saveAllData() {
            let data = list.map {
                [
                    "title": $0.title,  // $0 : 0번부터
                    "content": $0.content!,
                    "isComplete": $0.isComplete
                ]
            }
            
            print(type(of: data))
            let userDefaults = UserDefaults.standard
            userDefaults.set(data, forKey: "items")
            userDefaults.synchronize()
    }
    func loadAllData() {
            let userDefaults = UserDefaults.standard
            guard let data = userDefaults.object(forKey: "items") as? [[String: AnyObject]] else {
                return
            }
            
            print(data.description)
            
            // list 배열에 저장하기
            print(type(of: data))
            list = data.map {
                var title = $0["title"] as? String
                var content = $0["content"] as? String
                var isComplete = $0["isComplete"] as? Bool
                
                return TodoList(title: title!, content: content!, isComplete: isComplete!)
            }
        }
    
}
