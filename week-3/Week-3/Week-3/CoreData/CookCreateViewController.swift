//
//  CookCreateViewController.swift
//  Week-3
//
//  Created by Samed Biçer on 9.07.2021.
//

import UIKit
import CoreData

class CookCreateViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var cookImage: UIImageView!
    @IBOutlet weak var cookImageTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cookImage.isUserInteractionEnabled = true
        let cookImageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickPhoto))
        cookImage.addGestureRecognizer(cookImageTapRecognizer)
    }

    @objc func pickPhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        cookImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func saveButtonClick(_ sender: UIButton) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let newCook = NSEntityDescription.insertNewObject(forEntityName: "Cook", into: context)
        newCook.setValue(cookImageTextField.text, forKey: "name")
        let imageData = cookImage.image?.jpegData(compressionQuality: 0.5)
        newCook.setValue(imageData, forKey: "image")
        
        do {
            try context.save()
        } catch {
            print("Kaydedilemedi...")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
