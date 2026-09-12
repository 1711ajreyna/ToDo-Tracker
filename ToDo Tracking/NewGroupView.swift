import SwiftUI

struct NewGroupView: View {

    @Environment(\.dismiss) var dismiss

    @State private var groupName = ""

    @State private var selectedIcon = "list.bullet"

    var onSave: (TaskGroup) -> Void

    let icons = [
        "list.bullet",
        "heart.fill",
        "book.fill",
        "house.fill",
        "star.fill",
        "cart.fill"
    ]

    var body: some View {

        NavigationStack {

            Form {

                // SECTION 1: NAME OF THE GROUP

                Section("Group Name") {

                    TextField("e.g. Work, School", text: $groupName)

                }

                // SECTION 2: ICON

                Section("Select Icon") {

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {

                        ForEach(icons, id: \.self) { icon in

                            Image(systemName: icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 40)
                                .background(
                                    selectedIcon == icon
                                    ? Color.blue.opacity(0.3)
                                    : Color.clear)
                                        .foregroundStyle(selectedIcon == icon ? Color.purple : Color.gray)
                                .clipShape(Circle())
                                .onTapGesture {
                                    selectedIcon = icon
                                }

                        }

                    }
                    .padding(.vertical)

                }

            }

            .navigationTitle("New Group")

            .toolbar {
                // item 1: Left - Cancel
                
                ToolbarItem(placement: .cancellationAction) {

                    Button("Cancel") {

                        dismiss()

                    }

                }
                // item 2: right - Saving
                ToolbarItem(placement: .confirmationAction) {

                    Button("Save") {

                        let newGroup = TaskGroup(
                            title: groupName,
                            symbolName: selectedIcon,
                            tasks: []
                        )

                        onSave(newGroup)

                        dismiss()

                    }
                    .disabled(groupName.isEmpty) // disable save buttion if group name is empty

                }

            }

        }

    }

}
