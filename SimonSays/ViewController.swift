//
//  ViewController.swift
//  SimonSays
//
//  Created by Diego Moreno on 14/11/22.
//

import UIKit

class ViewController: UIViewController {

    let gameVC : GameViewController = GameViewController()
    
    @IBOutlet weak var lbScore: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "easy" {
            let destiny = segue.destination as! GameViewController
            destiny.difficult = 1
        } else if segue.identifier == "medium" {
            let destiny = segue.destination as! GameViewController
            destiny.difficult = 2
        } else if segue.identifier == "hard" {
            let destiny = segue.destination as! GameViewController
            destiny.difficult = 3
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lbScore.text = "Score: " + (gameVC.userDefault.string(forKey: "score") ?? "")
    }
}
