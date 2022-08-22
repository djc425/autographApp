//
//  CoreDataMethods.swift
//  AutographApp
//
//  Created by David Chester on 7/24/22.
//

import Foundation
import CoreData
import UIKit.UIApplication

enum CoreDataManagerErrors: Error {
    case couldNotLoad
    case couldNotSave
    case couldNotdelete
}

struct CoreDataManager {

    var loadedAutographs: [Autograph]

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    mutating func getAutographs() {
        do {
            let autographs = try context.fetch(AutographWithSignature.fetchRequest())
            for autograph in autographs {
                if let retrievedAutograph = autograph.autograph, let retrievedImage = autograph.image, let retrievedDate = autograph.date {
                    let retrievedAutograph = Autograph(date: retrievedDate, image: UIImage(data: retrievedImage)!, autograph: UIImage(data: retrievedAutograph)!)
                    loadedAutographs.append(retrievedAutograph)
                }
            }
        } catch {
            print(CoreDataManagerErrors.couldNotdelete.localizedDescription)
        }
       
    }

    func createAutograph(date: String, autograph: Data, image: Data) {
        let newAutograph = AutographWithSignature(context: context)
        newAutograph.date = date
        newAutograph.autograph = autograph
        newAutograph.image = image

        do {
            try context.save()
        } catch {
            print(CoreDataManagerErrors.couldNotSave.localizedDescription)
        }
    }

    func deleteAutograph(delete: AutographWithSignature){
        context.delete(delete)
        do {
            try context.save()
        } catch {
            print(CoreDataManagerErrors.couldNotdelete.localizedDescription)
        }
    }
}
