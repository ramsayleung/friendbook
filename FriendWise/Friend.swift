//
//  Friend.swift
//  FriendWise
//
//  Created by ramsayleung on 2024-02-28.
//

import Foundation
import SwiftData

@Model
class Friend: Codable, Identifiable{
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    var id: UUID
    var name: String
    
    init(id: UUID, name: String){
        self.id = id
        self.name = name
    }
    
    
    required init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        print("Decoding Friend with ID:", id)
        print("Decoding Friend with Name:", name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
}
