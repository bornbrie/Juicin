//
//  Juice.swift
//  Juicies
//
//  Created by Brianna Lee on 5/9/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

@objc(Juice)
class Juice: NSManagedObject, Codable {
    
    typealias ID = String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case color
        case createdAt
        case updatedAt
        case isEditing
    }
    
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var color: String
    @NSManaged var createdAt: Date
    @NSManaged var updatedAt: Date
    @NSManaged var isEditing: Bool
    
    required convenience init(from decoder: Decoder) throws {
        
        guard
            let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Juice", in: managedObjectContext)
        else {
            fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.color = try container.decode(String.self, forKey: .color)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.isEditing = try container.decode(Bool.self, forKey: .isEditing)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(color, forKey: .color)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(isEditing, forKey: .isEditing)
    }
}
