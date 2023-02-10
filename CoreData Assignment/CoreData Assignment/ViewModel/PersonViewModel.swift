//
//  PersonViewModel.swift
//  CoreData Assignment
//
//  Created by arifashraf on 23/11/21.
//

import Foundation
import CoreData

class PersonViewModel {
    
    var dbOperations: DBOperations
    
    init(_dbOperations: DBOperations) {
        dbOperations = _dbOperations
    }
    
    var request = Person.fetchRequest() as NSFetchRequest<Person>
    var people = [Person]()
    
    
    func fetchData() {
        self.people = dbOperations.fetchData()!
    }
    
    func saveData(name: String)  {
        dbOperations.saveData(name: name)
    }
    
}
