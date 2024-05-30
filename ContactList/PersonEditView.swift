//
//  PersonEditView.swift
//  ContactList
//
//  Created by Conner Yoon on 5/29/24.
//

import SwiftUI
import SwiftData
import PhotosUI
struct PersonEditView: View {
    @Bindable var person : Person
    @State private var photosPickerItem : PhotosPickerItem?
    @State private var profileImage : Image?
    @Environment (\.modelContext) var modelContext
    @Query private var quirks : [Quirk]
    @State private var quirkString : String = ""
    
    var body: some View {
        VStack{
            
            PhotosPicker("Select avatar", selection: $photosPickerItem, matching: .images)
            ProfilePicView(person: person, picSize: 200)
            TextField("Name", text: $person.name).textFieldStyle(.roundedBorder)
            GroupBox("Quirks") {
                List{
                    ForEach(person.quirks){ quirk in
                        Text(quirk.descrip)
                    }.onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            modelContext.delete(quirks[index])
                        }
                    })
                }
            }
            VStack{
                Text("Quirk").font(.caption)
                HStack{
                    TextField("Quirk", text: $quirkString)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                           addQuirkToPerson()
                        }
                    Button(action: {
                       addQuirkToPerson()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
                
            }.padding(.horizontal)
  
            
        }
        .onChange(of: photosPickerItem) {
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
    
    private func addQuirkToPerson(){
        let newQuirk = Quirk(descrip: quirkString)
        modelContext.insert(newQuirk)
        newQuirk.person = person
    }
}
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Person.self, configurations: config)
    Person.example.forEach { person in
        container.mainContext.insert(person)
    }
    return NavigationStack{PersonEditView(person: Person.example[0]).modelContainer(container)}
    
}
