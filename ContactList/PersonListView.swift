//
//  PersonListView.swift
//  ContactList
//
//  Created by Conner Yoon on 5/28/24.
//

import SwiftUI
import SwiftData
struct PersonListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var people : [Person]
    @State private var newPerson : Person?
    var body: some View {
        NavigationStack{
            List {
                ForEach(people){ person in
                    NavigationLink {
                        PersonEditView(person: person)
                    } label: {
                        HStack{
                            
                            if let data = person.imageData, let uiImage = UIImage(data: data){
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }
                            else {
                                Image(systemName: "person")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }
                            Text(person.name)
                        }
                    }
                    
                }
            }
            .toolbar{
                Button(action: {
                    newPerson = Person()
                    modelContext.insert(newPerson!)
                }, label: {
                    Image(systemName: "plus")
                })
            }.sheet(item: $newPerson, content: { person in
                PersonEditView(person: person)
            })
                
            
        }
    }
}
import PhotosUI
struct PersonEditView: View {
    @Bindable var person : Person
    @State private var photosPickerItem : PhotosPickerItem?
    @State private var profileImage : Image?
    var body: some View {
        VStack{
            
            PhotosPicker("Select avatar", selection: $photosPickerItem, matching: .images)
            if let data = person.imageData, let uiImage = UIImage(data: data){
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            }
            else {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            }
            TextField("Name", text: $person.name)
            
        }.onChange(of: photosPickerItem) {
            Task {
                if let data = try? await photosPickerItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        profileImage = Image(uiImage: uiImage)
                        person.imageData = data
                    }
                } else {
                    print("Failed")
                }
            }
        }
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Person.self, configurations: config)
    Person.example.forEach { person in
        container.mainContext.insert(person)
    }
    
    return NavigationStack{PersonListView() .modelContainer(container)}
}
