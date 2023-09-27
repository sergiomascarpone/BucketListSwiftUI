//
//  BucketListViewModel.swift
//  BucketListSwiftUI
//
//  Created by Sergio Mascarpone on 27.09.23.
//

import Foundation

class BucketListViewModel: ObservableObject {
    @Published var listItems: [BucketListItemModel] = [BucketListItemModel(name: "See the ocean"),
        BucketListItemModel(name: "Buy a house"),
        BucketListItemModel(name: "Visit Japan"),
        BucketListItemModel(name: "Visit China")]
    
    //MARK: - CRUD functions
    func createItem(name: String) {
        let newItem = BucketListItemModel(name: name)
        listItems.append(newItem)
        saveToPresistenceStore()
    }
    
    func toggleIsCompleted(item: BucketListItemModel) {
        guard let index = listItems.firstIndex(of: item) else { return }
        listItems[index].isCompleted.toggle()
        saveToPresistenceStore()
    }
    
    func deleteItem(index: IndexSet) {
        listItems.remove(atOffsets: index)
        saveToPresistenceStore()
    }
    
    //MARK: Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("BucketList.json")
        return fileURL
    }
    
    
    func saveToPresistenceStore() {
        do {
            let data = try JSONEncoder().encode(listItems)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error while saving")
        }
    }
    
    
    func loadFromToPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            listItems = try JSONDecoder().decode([BucketListItemModel].self, from: data)
        } catch {
            print("Error")
        }
    }
}
