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
    
    var viewModel = TrainerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themesTableView.dataSource = self
        themesTableView.delegate = self
        designScreenElements()
        viewModel.getThemes { [weak self] (isReady) in
            guard let `self` = self, isReady else {
                return
            }
            DispatchQueue.main.async {
                self.themesTableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getUnsolvedTasksCount { [weak self] (count) in
            guard let `self` = self else { return }
            self.notSolvedButton.setTitle("Нерешенные задачи (\(count))", for: .normal)
        }
    }
    
    func designScreenElements() {
        DesignService.setGradient(for: view)
        DesignService.designRedButton(notSolvedButton)
    }
    
    @IBAction func unsolvedTasksTapped(_ sender: UIButton) {
        Animations.swipeViewController(.fromRight, for: view)
        let unsolvedThemesViewController = UnsolvedThemesViewController()
        unsolvedThemesViewController.viewModel = UnsolvedThemesViewModel()
        unsolvedThemesViewController.viewModel.unsolvedTasks = viewModel.unsolvedTasks
        unsolvedThemesViewController.modalPresentationStyle = .fullScreen
        present(unsolvedThemesViewController, animated: true)
    }
}

extension TrainerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.themes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ThemeTableViewCell", owner: self, options: nil)?.first as! ThemeTableViewCell
        
        cell.themeName.text = viewModel.themes[indexPath.row]
        return cell
    }
}

extension TrainerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskViewController = TasksListViewController()
        viewModel.transportDataTo(taskViewController.viewModel, at: indexPath.row)
        taskViewController.modalPresentationStyle = .fullScreen
        present(taskViewController, animated: true)
    }
}
