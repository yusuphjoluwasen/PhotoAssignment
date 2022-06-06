//
//  Album+CoreDataProperties.swift
//  PhotosAssignment
//
//  Created by Guru on 02/06/2022.
//
//

import Foundation
import CoreData

extension Album {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Album> {
        return NSFetchRequest<Album>(entityName: "Album")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var savedTime: Double
}

extension Album : Identifiable {

}
