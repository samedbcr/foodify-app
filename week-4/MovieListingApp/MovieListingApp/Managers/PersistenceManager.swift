//
//  PersistenceManager.swift
//  MovieListingApp
//
//  Created by Samed Biçer on 25.07.2021.
//

import CoreData
import UIKit

final class PersistenceManager {
    static let shared = PersistenceManager()
    static var favoritedMovieIds = [Int]()
    private var context: NSManagedObjectContext!

    private init() {
        setupContext()
        getAllFavorites()
    }

    private func setupContext() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        context = appDelegate.persistentContainer.viewContext
    }

    private func getAllObjects() -> [Any]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print("Persistence getAllObjects() fetch Error")
            return nil
        }
    }

    func getAllFavorites() {
        Self.favoritedMovieIds = []

        guard let results = getAllObjects() else { return }
        for result in results as! [NSManagedObject] {
            guard let movieId = result.value(forKey: "movieId") as? Int else { return }
            Self.favoritedMovieIds.append(movieId)
        }
    }

    func addToFavorite(movieId: Int) {
        if !Self.favoritedMovieIds.contains(movieId) {
            let favoriteItem = NSEntityDescription.insertNewObject(forEntityName: "Favorite", into: context)
            favoriteItem.setValue(movieId, forKey: "movieId")
            do {
                try context.save()
                Self.favoritedMovieIds.append(movieId)
            } catch {
                print("Favori kaydedilemedi")
            }
        }
    }

    func deleteFromFavorite(movieId: Int) {
        guard let results = getAllObjects() else { return }
        for result in results as! [NSManagedObject] {
            guard let favoritedMovieId = result.value(forKey: "movieId") as? Int else { return }
            if movieId == favoritedMovieId {
                do {
                    context.delete(result)
                    try context.save()
                    if let index = Self.favoritedMovieIds.firstIndex(of: movieId) {
                        Self.favoritedMovieIds.remove(at: index)
                    }
                } catch {
                    print("deleteFromFavorite() deletion error")
                }
                return
            }
        }
    }

    func deleteAll() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
}
