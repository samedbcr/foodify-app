//
//  CookLIstViewController.swift
//  Week-3
//
//  Created by Samed Biçer on 9.07.2021.
//

import UIKit
import CoreData

class CookListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var cooks = [CookModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCooks()
    }

//    func deleteAll(entityName: String) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let context = appDelegate.persistentContainer.viewContext
//
//        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//
//        do {
//            try context.execute(deleteRequest)
//            try context.save()
//        } catch {
//            print ("There was an error")
//        }
//    }


    private func getCooks() {
        cooks.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cook")

        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    guard let name = result.value(forKey: "name") as? String else { return }
                    guard let imageData = result.value(forKey: "image") as? NSData else { return }
                    guard let id = result.value(forKey: "id") as? UUID else { return }
                    let image = UIImage(data: imageData as Data) ?? UIImage()
                    let cook = CookModel(id: id, name: name, image: image)
                    cooks.append(cook)
                }
                self.tableView.reloadData()
            } else {
                //TODO:
            }
        } catch {
            print("Error")
        }
    }

    private func deleteCook(cookId: UUID) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cook")

        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    guard let id = result.value(forKey: "id") as? UUID else { return }
                    if id.uuidString == cookId.uuidString {
                        context.delete(result)
                        try context.save()
                        return
                    }
                }
            }
        } catch {
            print("Error")
        }
    }

}

extension CookListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cookCell") as? CookTableViewCell else { return UITableViewCell() }
        cell.cookImageView.image = cooks[indexPath.row].image
        cell.cookLabel.text = cooks[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Are you sure you want to delete?", message: "If you delete this item, it will no longer be accessible.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
                self.deleteCook(cookId: self.cooks[indexPath.row].id)
                self.cooks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
