//
//  UserView.swift
//  FriendWise
//
//  Created by ramsayleung on 2024-02-28.
//

import SwiftUI
struct TagsView: View {
    let tags: [String]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tags, id: \.self) { tag in
                    Text("#\(tag)")
                        .font(.caption)
                        .foregroundColor(.blue)
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1)
                                .foregroundColor(.blue)
                        )
                }
            }
        }
        .frame(width: .infinity)
        
    }
}

struct UserView: View {
    let user: User
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.gray))
                    
                    
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.title)
                            .fontWeight(.bold)
                        HStack {
                            Text("\(user.age) years old, \(user.company)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            Circle()
                                .frame(width:10, height: 10)
                                .foregroundColor(user.isActive ? .green : .secondary)
                        }
                    }.padding(.top, 10)
                }
                
                if !user.address.isEmpty {
                    Text("Address: \(user.address)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                if !user.about.isEmpty {
                    Text("About: \(user.about)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("Tags:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                    TagsView(tags: user.tags)
                }
                
                if !user.friends.isEmpty {
                    Text("Friends:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    List{
                        ForEach(user.friends) { friend in
                            HStack {
                                // Optional: Include a friend profile picture (replace with placeholder or system icon)
                                Image(systemName: "person.2")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 10, height: 10)
                                
                                Text(friend.name)
                                    .font(.caption2)
                                    .foregroundColor(.blue) // Adjust color as needed
                            }
                        }
                        .listRowSeparator(.visible)
                    }
                    .listStyle(.plain)
                    .frame(maxHeight: 100) // Adjust height as needed
                }
            }
            .padding()
        }
    }
}



#Preview {
    let friend1 = Friend(id: UUID(), name: "Hawkins Patel")
    let friend2 = Friend(id: UUID(), name: "Berger Robertson")
    let user = User(id: UUID(),
                    isActive: true,
                    name: "Alford Rodriguez",
                    age: 26,
                    company: "Imkan",
                    email: "alfordrodriguez@imkan.com",
                    address: "907 Nelson Street, Cotopaxi, South Dakota, 5913",
                    about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.",
                    registered: Date.now,
                    tags: ["swift", "code", "popcorn"],
                    friends: [friend1, friend2])
    return UserView(user: user)
}
