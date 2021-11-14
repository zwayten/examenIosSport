//
//  ViewController.swift
//  examenIosSport
//
//  Created by Yassine Zitoun on 13/11/2021.
//

import UIKit

class ViewController: UIViewController {

    let exercices = ["Barbell back squat", "Barbell good morning", "Bench-press", "Bent over row", "Chin up", "Dumbbell triceps extension", "Glubridge", "Incline dumbbell bench press", "Incline dumbbell flye", "Overhead press", "Rack pull", "Seated dumbbell curl", "Seated dumbbell press", "Triceps-dip"]
    
    let categories = ["Legs And Abs", "Legs And Abs", "Chest And Triceps", "Back And Biceps", "Back And Biceps", "Chest And Triceps", "Legs And Abs","Chest And Triceps", "Chest And Triceps", "Shoulders", "Back And Biceps", "Back And Biceps", "Shoulders", "Chest And Triceps"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //protocol dataSource 3dad el rows fel tableau "activer dataSource"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exercices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "gymCell")
        let contentView = cell?.contentView
        
        let image = contentView?.viewWithTag(1) as! UIImageView
        let label2 = contentView?.viewWithTag(2) as! UILabel
        let label3 = contentView?.viewWithTag(3) as! UILabel
        
        image.image = UIImage(named: exercices[indexPath.row])
        label2.text = exercices[indexPath.row]
        label3.text = categories[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath
        performSegue(withIdentifier: "toDetail", sender: index)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let index = sender as! IndexPath
            let destination = segue.destination as! DetailsViewController
            
            destination.exercice = exercices[index.row]
            destination.categorie = categories[index.row]
        }
    }
    
    
    

}
