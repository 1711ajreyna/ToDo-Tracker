import SwiftUI

struct GroupStatsView: View {
    var tasks: [TaskItem]
    
    // Count the isCompleted total task
    var completedCount: Int{ tasks.filter {$0.isCompleted}.count}
    
    // Percentage isCompleted / Total Tasks
    var progress: Double { tasks.isEmpty ? 0 : Double(completedCount) / Double(tasks.count) }
    
    var body: some View {
        HStack {
            // Progress Ring
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundColor(.cyan)
                    .opacity(0.3)
                
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .trim(from: 0, to: progress)
                    .rotationEffect(.degrees(-90))
                    .foregroundColor(.cyan)
                Text("\(Int(progress * 100))%")
                    .font(.caption)
                    .bold()
                
            }
            .frame(width: 60, height: 60)
            .padding()
            
            // Text Info
            VStack(alignment: .leading) {
                Text("Tasks Progress")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("\(completedCount)/\(tasks.count)")
                    .font(.title)
                    .bold()
            }
            Spacer()  // push everything to the left
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal)
        }
    }
}
