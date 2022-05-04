//
//  CoreDataManager.swift
//  JHABIT
//
//  Created by JH on 2022/03/26.
//

import CoreData
import UIKit

final class CoreDataManager {
    
	// MARK: - Properties
    private var entityName: String
    private var entity: NSEntityDescription?

    private let managedContext: NSManagedObjectContext

    // MARK: - Initalize
    init(name: String) {
        entityName = name

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: name, in: managedContext)
    }

    func fetch() -> [NSManagedObject] {
        let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
//        request.returnsObjectsAsFaults = false

        // sort
//		let sort = NSSortDescriptor(key: "date", ascending: false)
//		request.sortDescriptors = [sort]

        do {
            return try managedContext.fetch(request)
        } catch {
            print("Found exception")
            return []
        }
    }

    func save(data: Commit) {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)

        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)
            managedObject.setValue(data.count, forKey: "count")
            managedObject.setValue(data.level, forKey: "level")
            managedObject.setValue(data.date, forKey: "date")
			managedObject.setValue(UUID(), forKey: "id")
            do {
                try managedContext.save()
            } catch {
				print("Could not save. \(error), \(error.localizedDescription)")
            }
        }
    }

    func update(data: Commit) {
		let request: NSFetchRequest<NSManagedObject> = NSFetchRequest.init(entityName: entityName)
		request.predicate = NSPredicate(format: "count = %@, level = %@", data.count, data.level)
		
        do {
			let udpateData = try managedContext.fetch(request)
			let objectUpdate = udpateData[0]
			
			objectUpdate.setValue(data.count, forKey: "count")
			objectUpdate.setValue(data.level, forKey: "level")
			
			try managedContext.save()
        } catch let error as NSError {
            print("Could not update. \(error), \(error.localizedDescription)")
        }
    }
	
    func delete(data: Commit) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
		request.predicate = NSPredicate(format: "id = %@", data.id.description)

        do {
			let delegateData = try managedContext.fetch(request)
			let objectToDelete = delegateData[0] as! NSManagedObject

			managedContext.delete(objectToDelete)
            try managedContext.save()
        } catch {
			print("Could not delegate. \(error), \(error.localizedDescription)")
        }
    }
	
}
