//
//  ContentView.swift
//  FriendWise
//
//  Created by ramsayleung on 2024-02-28.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
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
                isLoading = true
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
            users = try decoder.decode([User].self, from: data)
        }catch {
            print("Error downloading data:", error.localizedDescription)
            fatalError("Unable to download data")
        }
    }
}

#Preview {
    ContentView()
}
