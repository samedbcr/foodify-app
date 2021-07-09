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
                    let image = UIImage(data: imageData as Data) ?? UIImage()
                    let cook = CookModel(name: name, image: image)
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

}

extension CookListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cookCell") else { return UITableViewCell() }
        cell.textLabel?.text = cooks[indexPath.row].name
        cell.imageView?.image = cooks[indexPath.row].image
        return cell
    }


}
