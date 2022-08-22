//
//  AutographWithSignature+CoreDataProperties.swift
//  AutographApp
//
//  Created by David Chester on 7/24/22.
//
//

import Foundation
import CoreData


extension AutographWithSignature {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AutographWithSignature> {
        return NSFetchRequest<AutographWithSignature>(entityName: "AutographWithSignature")
    }

    @NSManaged public var autograph: Data?
    @NSManaged public var date: String?
    @NSManaged public var image: Data?

}

extension AutographWithSignature : Identifiable {

}
