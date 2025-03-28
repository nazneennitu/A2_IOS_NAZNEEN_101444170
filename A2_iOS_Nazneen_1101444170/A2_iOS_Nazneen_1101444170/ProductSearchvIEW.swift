//
//  ProductSearchvIEW.swift
//  A2_iOS_Nazneen_1101444170
//
//  Created by Nazneen Nitu on 2025-03-27.
//

import SwiftUI
import CoreData

struct ProductSearchView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default
    ) var allProducts: FetchedResults<Product>
    
    @State private var searchText = ""

    var filtered: [Product] {
        if searchText.isEmpty {
            return Array(allProducts)
        } else {
            return allProducts.filter {
                ($0.name?.localizedCaseInsensitiveContains(searchText) ?? false) ||
                ($0.productDescription?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
    }

    var body: some View {
        VStack {
            TextField("Search by name or description", text: $searchText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            List(filtered, id: \.self) { product in
                VStack(alignment: .leading) {
                    Text(product.name ?? "")
                        .font(.headline)
                    Text(product.productDescription ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Search Products")
    }
}
