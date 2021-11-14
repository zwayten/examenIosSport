//
//  WorkoutViewController.swift
//  examenIosSport
//
//  Created by Yassine Zitoun on 13/11/2021.
//

import UIKit
import CoreData

var workoutex = [String]()
var workoutcat = [String]()
var sr = [String]()


class WorkoutViewController: UIViewController {

    @IBOutlet var grid: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
    }
    
    func fetchData() {
        //3 default
        let appDelagate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelagate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Popsi")
                do {
                    let result = try managedContext.fetch(request)
                    for item in result {
                        workoutex.append(item.value(forKey: "exercice") as! String)
                        workoutcat.append(item.value(forKey: "categorie") as! String)
                        let a = String(describing: item.value(forKey: "steps")!)
                        let b = String(describing: item.value(forKey: "reps")!)
                        let abc = "\(a) / \(b)"
                        
                        sr.append(abc)
                    }
                } catch  {
                    print("cannot fetch : error")
                }
            }
    
    @IBAction func deleteall(_ sender: UIBarButtonItem) {
        delete()
        workoutex.removeAll()
        workoutcat.removeAll()
        sr.removeAll()
        grid.reloadData()
    
    }
    
    
    
    
    func delete() {
        //3default
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
               let pc = appDelegate.persistentContainer
               let mc = pc.viewContext
               
               let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Popsi")
               let deleteRequest =  NSBatchDeleteRequest(fetchRequest: request)
               do {
                   try mc.execute(deleteRequest)
                   try mc.save()
               } catch {
                   print("error")
               }
    }
    

}

extension WorkoutViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workoutex.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "workCell", for: indexPath)
        let contentView = cell.contentView
        
        
        let image = contentView.viewWithTag(1) as! UIImageView
        let lblex = contentView.viewWithTag(2) as! UILabel
        let labelcat = contentView.viewWithTag(3) as! UILabel
        let stepsreps = contentView.viewWithTag(4) as! UILabel
        
        image.image = UIImage(named: workoutex[indexPath.row])
        lblex.text = workoutex[indexPath.row]
        labelcat.text = workoutcat[indexPath.row]
        stepsreps.text = sr[indexPath.row]
        
        
        
        return cell
    }
    
    
}
