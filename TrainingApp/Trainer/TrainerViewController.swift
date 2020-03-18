//
//  TrainerViewController.swift
//  TrainingApp
//
//  Created by мак on 16/03/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import UIKit

class TrainerViewController: UIViewController {

    @IBOutlet weak var themesTableView: UITableView!
    @IBOutlet weak var notSolvedButton: UIButton!
    
    var themes = ["Магнетизм","Электричество","Кинематика","Динамика","Статика"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themesTableView.dataSource = self
        themesTableView.delegate = self
        designScreenElements()
    }
    
    func designScreenElements() {
        DesignService.setGradient(for: view)
        DesignService.designRedButton(notSolvedButton)
    }
    
}

extension TrainerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ThemeTableViewCell", owner: self, options: nil)?.first as! ThemeTableViewCell
        cell.themeName.text = themes[indexPath.row]
        return cell
    }
}

extension TrainerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        let taskViewController = TaskViewController()
        taskViewController.modalPresentationStyle = .fullScreen
        present(taskViewController, animated: true)
    }
}
