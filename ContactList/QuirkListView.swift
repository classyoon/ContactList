//
//  QuirkListView.swift
//  ContactList
//
//  Created by Conner Yoon on 5/29/24.
//

import SwiftUI
import SwiftData
struct QuirkListView: View {
    @Bindable var person : Person
    @State var newQuirk : String = ""
    var body: some View {
        List{
            HStack{
                TextField("New Quirks?", text: $newQuirk)
                Button(action: {
                    person.quirks.append(Quirk(descrip: newQuirk))
                    newQuirk = ""
                }, label: {
                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                })
            }
            ForEach(person.quirks){ quirk in
                Text(quirk.descrip)
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
    
    return NavigationStack{QuirkListView(person: Person.example[0]).modelContainer(container)}
}
