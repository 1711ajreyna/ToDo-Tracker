import SwiftUI

struct ContentView: View {

    @State private var tasksGroups = TaskGroup.sample

    @State private var selectedGroup: TaskGroup?

    @State private var columnVisibility:
        NavigationSplitViewVisibility = .all

    var body: some View {

        NavigationSplitView(columnVisibility: $columnVisibility) {

            List(selection: $selectedGroup) {

                ForEach(tasksGroups) { group in

                    NavigationLink(value: group) {

                        Label(
                            group.title,
                            systemImage: group.symbolName
                        )
                    }
                }
            }

            .navigationTitle("ToDo Tracking")
            .listStyle(.sidebar)

        } detail: {

            if let group = selectedGroup {

                if let index = tasksGroups.firstIndex(
                    where: { $0.id == group.id }
                ) {

                    TaskGroupDetailView(
                        group: $tasksGroups[index]
                    )
                }

            } else {

                ContentUnavailableView(
                    "Select a Group",
                    systemImage: "sidebar.left"
                )
            }
        }
    }
}
