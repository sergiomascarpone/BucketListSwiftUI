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
        BucketListItemModel(name: "Visit Japan")]
    
    func toggleIsCompleted(item: BucketListItemModel) {
        guard let index = listItems.firstIndex(of: item) else { return }
        listItems[index].isCompleted.toggle()
    }
    
    //MARK: Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("BucketList.json")
        return fileURL
    }
}
