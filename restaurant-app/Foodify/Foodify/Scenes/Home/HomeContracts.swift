//
//  HomeContracts.swift
//  Foodify
//
//  Created by Samed Biçer on 12.08.2021.
//

import Foundation
import FoodifyAPI

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
    var categories: [FoodifyAPI.Category] { get }
    var categoriesCount: Int { get }
    func load()
    func selectCategory(at index: Int)
}

enum HomeViewModelOutput {
    case setLoading(Bool)
    case reloadCategoryList
}

protocol HomeViewModelDelegate: AnyObject {
    func handleViewOutput(_ output: HomeViewModelOutput)
}
