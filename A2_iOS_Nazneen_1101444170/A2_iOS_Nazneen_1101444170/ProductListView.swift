//
//  ProductListView.swift
//  A2_iOS_Nazneen_1101444170
//
//  Created by Nazneen Nitu on 2025-03-27.
//

import SwiftUI
import CoreData

struct ProductListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default
    ) private var products: FetchedResults<Product>

    var body: some View {
        List {
            ForEach(products) { product in
                VStack(alignment: .leading) {
                    Text(product.name ?? "Unknown")
                        .font(.headline)
                    Text(product.productDescription ?? "No description")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("All Products")
    }
}
