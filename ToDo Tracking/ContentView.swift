import SwiftUI

struct ContentView: View {

    @State private var tasksGroups = TaskGroup.sample   // See mock data

    @State private var selectedGroup: TaskGroup?   // Selected group

    @State private var columnVisibility:
        NavigationSplitViewVisibility = .all  // Navigation side panel

    @State private var isShowingAddGroup = false
    
    var body: some View {

        NavigationSplitView(columnVisibility: $columnVisibility) {
         // SIDEBAR
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
            .toolbar {
                Button {
                    isShowingAddGroup = true
                } label: {
                    Image(systemName: "plus")
                }
            }
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
                    systemImage: "sidebar.left")
            }
        }
        .sheet(isPresented: $isShowingAddGroup){
            NewGroupView { newGroup in
                tasksGroups.append(newGroup)
                selectedGroup = newGroup
            }
        }
    }
}
