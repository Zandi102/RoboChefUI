import SwiftUI

struct GroceryView: View {
    @State var items: [String] = [
        "Cheese", "Chicken broth", "Cupcakes", "Steak", "Chicken"
    ]

    @State var pantryItems: [String] = [
        "Tostidos pizza rolls", "Ice Cream", "Spinach"
    ]

    @State var newItem: String = " "
    @State var newPantryItem: String = " "
    @State var showAddGroceryFields = false // Track if grocery add fields should be shown
    @State var showAddPantryFields = false // Track if pantry add fields should be shown
    @State var showEdit = false // Track if edit mode is active

    func deleteGroceryItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }

    func deletePantryItem(indexSet: IndexSet) {
        pantryItems.remove(atOffsets: indexSet)
    }

    func moveGroceryItem(indices: IndexSet, newOffset: Int) {
        items.move(fromOffsets: indices, toOffset: newOffset)
    }

    func movePantryItem(indices: IndexSet, newOffset: Int) {
        pantryItems.move(fromOffsets: indices, toOffset: newOffset)
    }

    func addGroceryItem() {
        if !newItem.isEmpty {
            items.append(newItem)
            newItem = ""
        }
    }

    func addPantryItem() {
        if !newPantryItem.isEmpty {
            pantryItems.append(newPantryItem)
            newPantryItem = ""
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(
                        header:
                            HStack {
                                Image(systemName: "cart.fill")
                                    .foregroundColor(Color("color2"))
                                Text("Shopping List")
                                    .font(.title)
                                    .foregroundColor(Color("color2"))
                                    .padding(.trailing, 100)
                                Button("+") {
                                    alertTF(title: "Add Item", message: "Please enter an item to add", hintText: "Chocolate", primaryTitle: "Add Item", secondaryTitle: "Cancel") {text in
                                        newItem = text
                                        addGroceryItem()
                                    }
                                    secondaryAction: {
                                        print("cancelled")
                                    }
                                }.foregroundColor(Color("color3"))
                            }
                    ) {
                        ForEach(items, id: \.self) { item in
                            HStack {
                                Image(systemName: "cart")
                                    .foregroundColor(Color("color3"))
                                Text(item)
                                    .font(.body)
                            }
                        }
                        .onDelete(perform: deleteGroceryItem)
                        .onMove(perform: moveGroceryItem)
                    }
                    .listStyle(.plain)
                    .accentColor(Color("color3"))

                    Section(
                        header:
                            HStack {
                                Image(systemName: "bag.fill")
                                    .foregroundColor(Color("color2"))
                                Text("My Pantry")
                                    .font(.title)
                                    .foregroundColor(Color("color2"))
                                    .padding(.trailing, 145)
                                Button("+") {
                                    alertTF(title: "Add Item", message: "Please enter an item to add", hintText: "Chocolate", primaryTitle: "Add Item", secondaryTitle: "Cancel") {text in
                                        newPantryItem = text
                                        addPantryItem()
                                    }
                                    secondaryAction: {
                                        print("cancelled")
                                    }
                                }.foregroundColor(Color("color3"))
                            }
                    ) {
                        ForEach(pantryItems, id: \.self) { item in
                            HStack {
                                Image(systemName: "bag")
                                    .foregroundColor(Color("color3"))
                                Text(item)
                                    .font(.body)
                            }
                        }
                        .onDelete(perform: deletePantryItem)
                        .onMove(perform: movePantryItem)
                    }
                    .listStyle(.plain)
                    .accentColor(Color("color3"))
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton().accentColor(Color("color3"))
                    }
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Grocery_Previews: PreviewProvider {
    static var previews: some View {
        GroceryView()
    }
}

extension View {
    func alertTF(title: String, message: String, hintText: String, primaryTitle: String, secondaryTitle: String, primaryAction: @escaping (String) -> (), secondaryAction: @escaping () -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField {field in
            field.placeholder = hintText;
        }
        
        alert.addAction(.init(title: secondaryTitle, style: .cancel, handler: { _ in
            secondaryAction()
        }))
        
        alert.addAction(.init(title: primaryTitle, style: .default, handler: { _ in
            if let text = alert.textFields?[0].text{
                primaryAction(text)
            }
            else {
                primaryAction("")
            }
        }))
        rootController().present(alert, animated: true, completion: nil)
    }
    
    func rootController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
}

