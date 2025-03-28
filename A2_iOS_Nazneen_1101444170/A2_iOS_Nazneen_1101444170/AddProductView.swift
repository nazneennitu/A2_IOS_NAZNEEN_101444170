//
//  AddProductView.swift
//  A2_iOS_Nazneen_1101444170
//
//  Created by Nazneen Nitu on 2025-03-27.
//

import SwiftUI
import CoreData
   
struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var desc = ""
    @State private var price = ""
    @State private var provider = ""

    var body: some View {
        Form {
            TextField("Product Name", text: $name)
            TextField("Description", text: $desc)
            TextField("Price", text: $price)
                .keyboardType(.decimalPad)
            TextField("Provider", text: $provider)

            Button("Save") {
                let newProduct = Product(context: viewContext)
                newProduct.productID = UUID()
                newProduct.name = name
                newProduct.productDescription = desc
                newProduct.price = price
                newProduct.provider = provider
                newProduct.timestamp = Date()

                try? viewContext.save()
                dismiss()
            }
        }
        .navigationTitle("Add Product")
    }
}
