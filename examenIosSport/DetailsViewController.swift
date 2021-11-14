//
//  DetailsViewController.swift
//  examenIosSport
//
//  Created by Yassine Zitoun on 13/11/2021.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {

    //destination var "segue"
    var exercice: String?
    var categorie: String?
    
    var setsValue = 0
    var repsValue = 0
    

    
    //outlets
    
    @IBOutlet var image: UIImageView!
    
    @IBOutlet var exLbl: UILabel!
    
    @IBOutlet var catLbl: UILabel!

    @IBOutlet var stepslbl: UILabel!
    
    @IBOutlet var repslbl: UILabel!
    
    //actions
    
    @IBAction func stepsStepper(_ sender: UIStepper) {
        setsValue = Int(sender.value)
        stepslbl.text = String(setsValue)
        
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        let test = checkExercie(exercice: exercice!)
        if test == false {
            insert()
            popAlert(a: "success", b: "exercice added")
        } else {
          popAlert(a: "warning", b: "exercice already exist")
        }
    }
    
    @IBAction func repsStepper(_ sender: UIStepper) {
        repsValue = Int(sender.value)
        repslbl.text = String(repsValue)
        
    }
    
    func popAlert(a: String, b:String) {
        let alert = UIAlertController(title: a, message: b, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = UIImage(named: exercice!)
        exLbl.text = exercice!
        catLbl.text = categorie!
        // Do any additional setup after loading the view.
    }
    
    
    func insert() {
        //3 default
        let appDelagate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelagate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        //insert
        let entityDescription = NSEntityDescription.entity(forEntityName: "Popsi", in: managedContext)
        let object = NSManagedObject.init(entity: entityDescription!, insertInto: managedContext)
        
        //ta3mir object
        object.setValue(exercice!, forKey: "exercice")
        object.setValue(categorie!, forKey: "categorie")
        object.setValue(setsValue, forKey: "steps")
        object.setValue(repsValue, forKey: "reps")
        
        do {
            try managedContext.save()
        } catch  {
            print("error")
        }
        
    }
    
    
    func checkExercie(exercice: String ) -> Bool {
        var e = false
        //3 default
        let appDelagate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelagate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Popsi")
        let predicate = NSPredicate(format: "exercice = %@", exercice)
        request.predicate = predicate
        
        do {
            let result = try managedContext.fetch(request)
            if result.count > 0 {
                e = true
            }
                
        } catch  {
            print("error")
        }
        return e
    }
    
    

   

}
