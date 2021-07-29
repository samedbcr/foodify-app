//
//  PersistenceManager.swift
//  VideoGamesApp
//
//  Created by Samed Biçer on 28.07.2021.
//

import UIKit
import CoreData

final class PersistenceManager {
    static let shared = PersistenceManager()
    static var favoritedGames = [Game]()
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
        Self.favoritedGames = []

        guard let results = getAllObjects() else { return }
        for result in results as! [NSManagedObject] {
            guard let id = result.value(forKey: "id") as? Int else { return }
            guard let name = result.value(forKey: "name") as? String else { return }
            guard let rating = result.value(forKey: "rating") as? Double else { return }
            guard let backgroundImage = result.value(forKey: "backgroundImage") as? String else { return }
            guard let released = result.value(forKey: "released") as? String else { return }
            let game = Game(id: id, name: name, released: released, backgroundImage: backgroundImage, rating: rating, metacritic: nil, description: nil)

            Self.favoritedGames.append(game)
        }
    }

    func addToFavorite(game: Game) {
//        if !Self.favoritedGames.contains(game) {
        let favoriteItem = NSEntityDescription.insertNewObject(forEntityName: "Favorite", into: context)
        favoriteItem.setValue(game.id, forKey: "id")
        favoriteItem.setValue(game.name, forKey: "name")
        favoriteItem.setValue(game.rating, forKey: "rating")
        favoriteItem.setValue(game.backgroundImage, forKey: "backgroundImage")
        favoriteItem.setValue(game.released, forKey: "released")
        do {
            try context.save()
            Self.favoritedGames.append(game)
        } catch {
            print("Favori kaydedilemedi")
        }
//        }
    }

    func deleteFromFavorite(gameId: Int) {
        guard let results = getAllObjects() else { return }
        for result in results as! [NSManagedObject] {
            guard let favoritedGameId = result.value(forKey: "id") as? Int else { return }
            if gameId == favoritedGameId {
                do {
                    context.delete(result)
                    try context.save()
                    if let index = Self.favoritedGames.firstIndex(where: { $0.id == gameId }) {
                        Self.favoritedGames.remove(at: index)
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
