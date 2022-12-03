//
//  GameViewController.swift
//  SimonSays
//
//  Created by Diego Moreno on 1/12/22.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var topBar: UINavigationItem!
    @IBOutlet weak var ivPattern: UIImageView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    private var imageList = [UIImage(named: "felis"), UIImage(named: "perro_sad"), UIImage(named: "perro_ok"), UIImage(named: "uwu")]
    private var imagesClicked : [UIImage] = []
    private var gameImages : [UIImage] = []
    
    let userDefault = UserDefaults.standard
    var score = 0
    var difficult = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ivPattern.layer.cornerRadius = 10.0
        ivPattern.layer.masksToBounds = true
        btn1.layer.cornerRadius = 10.0
        btn1.layer.masksToBounds = true
        btn2.layer.cornerRadius = 10.0
        btn2.layer.masksToBounds = true
        btn3.layer.cornerRadius = 10.0
        btn3.layer.masksToBounds = true
        btn4.layer.cornerRadius = 10.0
        btn4.layer.masksToBounds = true
        
        play()
    }
    
    func play() {
        if difficult == 1 {
            easy()
        } else if difficult == 2 {
            medium()
        } else {
            hard()
        }
    }
    
    func easy() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: disableGame)
        changeImage(time: 1)
        changeImage(time: 2)
        changeImage(time: 3)
        changeImage(time: 4)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: enableGame)
    }
    
    func medium() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: disableGame)
        changeImage(time: 1)
        changeImage(time: 1.5)
        changeImage(time: 2)
        changeImage(time: 2.5)
        changeImage(time: 3)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: enableGame)
    }
    
    func hard() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: disableGame)
        changeImage(time: 0.5)
        changeImage(time: 0.7)
        changeImage(time: 1)
        changeImage(time: 1.3)
        changeImage(time: 1.5)
        changeImage(time: 1.7)
        changeImage(time: 2)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: enableGame)
    }
    
    func randomizeImage() {
        let randomImage = Int.random(in: 0...3)
        ivPattern.image = imageList[randomImage]
    }
    
    func changeImage(time : TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            UIView.transition(with: self.ivPattern, duration: 0.3, options: .transitionFlipFromLeft, animations: {
                self.randomizeImage()
                self.gameImages.append(self.ivPattern.image!)
            }, completion: nil)
        }
    }
    
    func compareArrays() {
        if gameImages.elementsEqual(imagesClicked) {
            topBar.title = "Correcto :D"
            youWin()
            print(score)
        } else {
            topBar.title = "Incorrecto D:"
            gameOver()
            print(score)
        }
    }
    func checkUserinput(images : Int) {
        if imagesClicked.count == images {
            compareArrays()
            disableGame()
        }
    }
    
    func checkDifficulty() {
        if difficult == 1 {
            checkUserinput(images: 4)
        } else if difficult == 2 {
            checkUserinput(images: 5)
        } else {
            checkUserinput(images: 7)
        }
    }
    
    @IBAction func btn1Action(_ sender: Any) {
        imagesClicked.append(UIImage(named: "felis")!)
        checkDifficulty()
    }
    @IBAction func btn2Action(_ sender: Any) {
        imagesClicked.append(UIImage(named: "perro_ok")!)
        checkDifficulty()
    }
    @IBAction func btn3Action(_ sender: Any) {
        imagesClicked.append(UIImage(named: "perro_sad")!)
        checkDifficulty()
    }
    @IBAction func btn4Action(_ sender: Any) {
        imagesClicked.append(UIImage(named: "uwu")!)
        checkDifficulty()
    }
    
    func disableGame() {
        btn1.isEnabled = false
        btn2.isEnabled = false
        btn3.isEnabled = false
        btn4.isEnabled = false
    }
    
    func enableGame() {
        btn1.isEnabled = true
        btn2.isEnabled = true
        btn3.isEnabled = true
        btn4.isEnabled = true
    }
    
    func youWin() {
        let win = UIAlertController(title: "You win!!", message: "Has ganado", preferredStyle: UIAlertController.Style.alert)
        win.addAction(UIAlertAction(title: "Salir", style: UIAlertAction.Style.default, handler: {
            (action) in
            
        }))
        score = userDefault.integer(forKey: "score")
        score += 10
        userDefault.set(score, forKey: "score")
        self.present(win, animated: true, completion: nil)
    }

    func gameOver() {
        let gameOver = UIAlertController(title: "Game over", message: "Has perdido", preferredStyle: UIAlertController.Style.alert)
        gameOver.addAction(UIAlertAction(title: "Salir", style: UIAlertAction.Style.default, handler: {
            (action) in
        }))
        score = userDefault.integer(forKey: "score")
        score -= 10
        userDefault.set(score, forKey: "score")
        self.present(gameOver, animated: true, completion: nil)
    }
}
