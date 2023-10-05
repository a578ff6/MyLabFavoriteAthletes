//
//  AthleteListTableViewController.swift
//  MyLabFavoriteAthletes
//
//  Created by 曹家瑋 on 2023/10/5.
//

import UIKit

class AthleteListTableViewController: UITableViewController {

    // MARK: - Property Keys
    // 用於標識重用的cell和Segues的靜態屬性
    struct PropertyKeys {
        static let athleteCell = "AthleteCell"
        static let addAthleteSegue = "AddAthlete"
        static let editAthleteSegue = "EditAthlete"
    }
    
    // MARK: - Properties
    // 存儲運動員數據的陣列
    var athletes: [AthleteInforation] = []
    
    
    // MARK: - View Lifecycle
    // 加載視圖時調用
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 視圖將要出現時調用，用於刷新數據
    // 在 viewWillAppear(_:) 中調用 reloadData()
    // 每次視圖將要出現在螢幕上時，數據都會被重新加載，保證用戶看到的總是最新的數據。
    // 如果數據集非常大，或者數據加載和/或單元格配置非常複雜，頻繁地調用 reloadData() 可能導致性能問題。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()          // 刷新表格數據
    }
    
    // MARK: - Navigation
    // 執行添加運動員的Segue
    @IBSegueAction func addAthlete(_ coder: NSCoder) -> AthleteDetailViewController? {
        // 初始化時不傳遞運動員數據（為新建運動員）
        return AthleteDetailViewController(coder: coder, athlete: nil)
    }
    
    // 執行編輯運動員的Segue
    @IBSegueAction func EditAthlete(_ coder: NSCoder, sender: Any?) -> AthleteDetailViewController? {
        // 決定被選擇編輯的運動員
        let athleteToEdit: AthleteInforation?
        
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            // 從陣列中獲取運動員對象
            athleteToEdit = athletes[indexPath.row]
        } else {
            // 若無，設置為nil
            athleteToEdit = nil
        }
        
        // 返回AthleteDetailViewController，初始化時傳遞運動員數據
        return AthleteDetailViewController(coder: coder, athlete: athleteToEdit)
    }
    
    // 返回到此視圖控制器時執行的操作
    @IBAction func unwindToAthleteTableViewController(_ segue: UIStoryboardSegue) {
        // 確保來源控制器和運動員數據可用
        guard let athleteDetailViewController = segue.source as? AthleteDetailViewController,
              let athlete = athleteDetailViewController.athlete else { return }
        
        // 更新已有數據
        if let selecteeIndexPath = tableView.indexPathForSelectedRow {
            athletes[selecteeIndexPath.row] = athlete
        } else {
            // 添加新運動員數據並在表格視圖中插入新的行
            athletes.append(athlete)
 
        }
    }

    // MARK: - Table view data source

    // 返回表格視圖的行數
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return athletes.count
    }

    // 配置並返回表格視圖的單元格
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.athleteCell, for: indexPath)

        // 獲取當前行對應的運動員數據
        let athlete = athletes[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text =  athlete.name
        content.secondaryText = athlete.description
        cell.contentConfiguration = content
        
        return cell
    }

}
