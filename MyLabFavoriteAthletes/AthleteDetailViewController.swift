//
//  AthleteDetailViewController.swift
//  MyLabFavoriteAthletes
//
//  Created by 曹家瑋 on 2023/10/5.
//

import UIKit

// 展示和編輯運動員詳細資訊
class AthleteDetailViewController: UIViewController {

    // MARK: - PropertyKeys
    // 包含用於識別segue的靜態屬性
    struct PropertyKeys {
        static let unwindToListSegue = "unwindToAthleteListTableViewController"
    }
    
    // MARK: - Properties
    // 存儲當前界面顯示的運動員資訊
    var athlete: AthleteInforation?
    
    // MARK: - IBOutlets
    // 用於顯示和編輯運動員訊息的TextField
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var leagueTextField: UITextField!
    @IBOutlet weak var teamTextField: UITextField!

    // MARK: - Initializers
    // 允許在初始化的時候傳入一個AthleteInformation對象
    init?(coder: NSCoder, athlete: AthleteInforation?) {
        self.athlete = athlete
        super.init(coder: coder)
    }
    
    // 實現required初始化器
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Lifecycle
    // 在視圖加載後調用，此時可以更新UI
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }
    
    // MARK: - IBActions
    // 處理使用者點擊Save按鈕
    @IBAction func saveAthleteInformationButtonTapped(_ sender: UIButton) {
        // 檢查TextField中的值是否都有有效內容
        guard let name = nameTextField.text,
              let ageString = ageTextField.text,
              let age = Int(ageString),
              let league = leagueTextField.text,
              let team = teamTextField.text else { return }
        
        // 使用TextField中的值來創建一個新的AthleteInformation對象並賦值給athlete變量
        athlete = AthleteInforation(name: name, age: age, league: league, team: team)
        
        // 執行回退的segue，返回上一個視圖控制器（）
        performSegue(withIdentifier: PropertyKeys.unwindToListSegue, sender: self)
    }

    // MARK: - Utility Methods
    // 更新界面的顯示，將athlète變量中的值顯示到對應的文本框中。（當從List點擊運動員時進入到Detail有關聯）
    func updateView() {
        // 檢查是否有值
        guard let athlete = athlete else { return }
        
        // 將athlete變數中的值賦予給對應的TextField
        nameTextField.text = athlete.name
        ageTextField.text = String(athlete.age)
        leagueTextField.text = athlete.league
        teamTextField.text = athlete.team
    }

}
