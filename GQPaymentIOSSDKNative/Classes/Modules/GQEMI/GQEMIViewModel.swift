//
//  GQEMIViewModel.swift
//  TestCases_Example
//
//  Created by valentine on 15/02/24.
//

import Foundation

protocol GQEMIViewModelType {
    var numberOfItems: Int { get }
    
    func getItem(at index: Int) -> String?
}

class GQEMIViewModel: GQEMIViewModelType {
    
    private var items: [String]? = ["A", "B", "C", "D", "E", "F"]
    
    var numberOfItems: Int {
        return self.items?.count ?? 0
    }
    
    func getItem(at index: Int) -> String? {
        guard index < self.items?.count ?? 0 else { return nil }
        return self.items?[index]
    }
    
}
