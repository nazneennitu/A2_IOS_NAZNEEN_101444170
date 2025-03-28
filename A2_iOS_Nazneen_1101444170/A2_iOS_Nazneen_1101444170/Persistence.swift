//
//  Persistence.swift
//  A2_iOS_Nazneen_1101444170
//
//  Created by Nazneen Nitu on 2025-03-27.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // MARK: - Preview for SwiftUI Previews
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        // Create a sample product
        let newProduct = Product(context: viewContext)
        newProduct.productID = UUID()
        newProduct.name = "Sample"
        newProduct.productDescription = "Sample Description"
        newProduct.price = "0.00"
        newProduct.provider = "Demo Provider"
        newProduct.timestamp = Date()

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

        return result
    }()

    // MARK: - Persistent Container Setup
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "A2_iOS_Nazneen_1101444170") // Make sure this matches your .xcdatamodeld file name

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this with better error handling in a real app
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
