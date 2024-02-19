//
//  PaymentMethodViewModel.swift
//  TestCases_Example
//
//  Created by valentine on 13/02/24.
//

import Foundation

protocol PaymentMethodsViewModelType {
    var selectedIndex: Int? { get set }
    var numberOfItems: Int { get }
    var firstIndex: Int { get }
    var lastIndex: Int { get }
    var canProceed: Bool { get }
    
    func fetchItems()
    func getItem(at index: Int) -> String?
}

class PaymentMethodsViewModel: PaymentMethodsViewModelType {
    
    var selectedIndex: Int?
    var items: [String]?
    
    var canProceed: Bool {
        return self.selectedIndex != nil
    }
    
    var numberOfItems: Int {
        return self.items?.count ?? 0
    }
    
    var firstIndex: Int {
        return 0
    }
    
    var lastIndex: Int {
        return (self.items?.count ?? 1) - 1
    }
    
    func fetchItems() {
        self.items = ["A", "B", "C"]
    }

    func getItem(at index: Int) -> String? {
        guard index < self.items?.count ?? 0 else { return nil }
        return self.items?[index]
    }
}
