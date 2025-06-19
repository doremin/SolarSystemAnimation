//
//  Main.swift
//  SolarSystemAnimation
//
//  Created by doremin on 6/18/25.
//

import UIKit

final class MainViewController: UITableViewController {
    private enum Destination: Int, CaseIterable {
        case coreAnimation = 0
        case uiKit
        
        var title: String {
            switch self {
            case .uiKit:
                "UIKit"
            case .coreAnimation:
                "Core Animation"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Destination.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = Destination(rawValue: indexPath.row)?.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let destination = Destination(rawValue: indexPath.row) else { return }
        
        let vc: UIViewController
        switch destination {
        case .coreAnimation:
            vc = SolarSystemCAViewController()
        case .uiKit:
            vc = SolarSystemViewController()
        }
        
        present(vc, animated: true)
    }
}
