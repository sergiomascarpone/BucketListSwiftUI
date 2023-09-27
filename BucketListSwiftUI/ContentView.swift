//
//  ContentView.swift
//  BucketListSwiftUI
//
//  Created by Sergio Mascarpone on 27.09.23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = BucketListViewModel()
    @State var listItemName = ""
    
    var body: some View {
        VStack {
            TextField("", text: $listItemName)
                .onSubmit {
                    viewModel.createItem(name: listItemName)
                    listItemName = ""
                }
                .padding(.all)
                .border(Color(uiColor: .cyan))
                .shadow(radius: 5)
            //BacketList
            List {
                ForEach(viewModel.listItems) { item in
                    HStack(spacing: 20) {
                        Button {
                            viewModel.toggleIsCompleted(item: item)
                        } label: {
                            Image(systemName:  item.isCompleted ? "pin.circle.fill" : "pin.circle")
                                .foregroundColor(Color(uiColor: .black))
                                .font(.system(size: 30))
                        }
                        Text(item.name)
                    }
                }
                .onDelete(perform: viewModel.deleteItem(index:))
                .frame(minHeight: 50)
                .listRowSeparator(.hidden, edges: .all)
            }
        }
        .padding()
        .navigationTitle("Bucket List")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .onAppear {
        viewModel.loadFromToPersistenceStore()
    }
 }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

