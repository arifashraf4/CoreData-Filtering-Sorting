//
//  DBOperations.swift
//  CoreData Assignment
//
//  Created by arifashraf on 17/11/21.
//

import Foundation

final class DBOperations {
    
    let context = AppDelegate.shared.context
    let sort = NSSortDescriptor(key: #keyPath(Person.name), ascending: true)
    
    func saveData(name: String?) {
        let personEntity = Person(context: context)
        personEntity.name = name
        do {
            try self.context.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func fetchData() -> [Person]? {
        do {
            let fetchRequest = Person.fetchRequest()
            
            fetchRequest.sortDescriptors = [sort]
            return try self.context.fetch(fetchRequest)
        }
        catch{
            print("Error:\(error.localizedDescription)")
        }
        return nil
    }
    
}
