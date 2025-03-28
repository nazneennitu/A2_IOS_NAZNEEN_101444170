//
//  ContentView.swift
//  A2_iOS_Nazneen_1101444170
//
//  Created by Nazneen Nitu on 2025-03-27.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    // Fetch all products sorted by name
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(products) { product in
                        NavigationLink {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("🆔 ID: \(product.productID?.uuidString ?? "N/A")")
                                Text("👕 Name: \(product.name ?? "Unknown")")
                                Text("📦 Description: \(product.productDescription ?? "No description")")
                                Text("💵 Price: ₦\(product.price ?? "0.00")")
                                Text("🏪 Provider: \(product.provider ?? "Unknown")")
                                if let timestamp = product.timestamp {
                                    Text("🕓 Added: \(timestamp, formatter: itemFormatter)")
                                }
                            }
                            .padding()
                        } label: {
                            VStack(alignment: .leading) {
                                Text(product.name ?? "")
                                    .font(.headline)
                                Text("Description: \(product.productDescription ?? "")")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete(perform: deleteProducts)
                }

                // 🔗 Navigation Links
                VStack(spacing: 10) {
                    NavigationLink("➕ Add New Product", destination: AddProductView())
                    NavigationLink("🔍 Search Product", destination: ProductSearchView())
                    NavigationLink("📃 See Full List", destination: ProductListView())
                }
                .padding()
            }
            .navigationTitle("Products")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addProduct) {
                        Label("Add Sample", systemImage: "plus")
                    }
                }
            }

            Text("Select a product")
                .foregroundColor(.gray)
        }
    }

    // MARK: - Add Sample Product
    private func addProduct() {
        withAnimation {
            let newProduct = Product(context: viewContext)
            newProduct.productID = UUID()
            newProduct.name = "Shirt"
            newProduct.productDescription = "Medium"
            newProduct.price = "250"
            newProduct.provider = "Nazneen"
            newProduct.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    // MARK: - Delete Products
    private func deleteProducts(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

// MARK: - Date Formatter
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
