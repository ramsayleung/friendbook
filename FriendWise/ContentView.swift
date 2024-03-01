//
//  ContentView.swift
//  FriendWise
//
//  Created by ramsayleung on 2024-02-28.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(animation: .default) var users: [User]
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            if isLoading {
                ProgressView() {
                    Text("Loading...")
                }
            }
            
            List{
                ForEach(users){ user in
                    NavigationLink{
                        UserView(user: user)
                    } label: {
                        VStack(alignment: .leading){
                            Text(user.name)
                                .font(.headline)
                            
                            HStack {
                                Circle()
                                    .frame(width:10, height: 10)
                                    .foregroundColor(user.isActive ? .green : .secondary)
                                Text(String(user.age))
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("FriendBook")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .onAppear {
            Task {
                isLoading = users.isEmpty
                await fetchUsers()
                isLoading = false // Update loading state after fetching
            }
        }
    }
    
    func fetchUsers() async {
        guard users.isEmpty else{
            return
        }
        
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let downloadedUsers = try decoder.decode([User].self, from: data)
            print("downloadedUsers size: \(downloadedUsers.count)")
            for user in downloadedUsers {
                modelContext.insert(user)
            }
            print("insert completed: \(downloadedUsers.count)")
        }catch {
            print("Error downloading data:", error.localizedDescription)
            fatalError("Unable to download data")
        }
    }
}

#Preview {
    ContentView()
}
