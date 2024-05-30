//
//  PersonListView.swift
//  ContactList
//
//  Created by Conner Yoon on 5/28/24.
//

import SwiftUI
import SwiftData

struct ProfilePicView :View {
    var person : Person
    var picSize : CGFloat
    
    var body: some View {
            if let data = person.imageData, let uiImage = UIImage(data: data){
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: picSize, height: picSize)
                    .clipShape(Circle())
            }
            else {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFill()
                    .frame(width: picSize, height: picSize)
                    .clipShape(Circle())
            }
        }
    
}
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
                            ProfilePicView(person: person, picSize: 50)
                            Text(person.name)
                        }
                    }
                    
                }
                .onDelete(perform: { indexSet in
                    indexSet.forEach { index in
                        modelContext.delete(people[index])
                    }
                })
            }
            .navigationTitle("My Contacts")
            .toolbarBackground(.green,
                               for: .navigationBar)
            .toolbarBackground(.visible,
                               for: .navigationBar)//THIS WAS IT
//            .navigationBarTitleDisplayMode(.inline)
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



#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Person.self, configurations: config)
    Person.example.forEach { person in
        container.mainContext.insert(person)
    }
    
    return NavigationStack{PersonListView() .modelContainer(container)}
}
