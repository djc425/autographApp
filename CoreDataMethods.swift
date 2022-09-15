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

protocol CoreDataManagerDelegate {
    func didUpdateUI(coreDataManager: CoreDataManager, autoGraph: AutographWithSignature)

    func didFailWithError(error: Error)

}

struct CoreDataManager {

    static let shared = CoreDataManager()

    let collectionVewGallery = GalleryUICollectionView()

    var delegate: CoreDataManagerDelegate?
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func getAutographs() {
       do {
           let autographs = try context.fetch(AutographWithSignature.fetchRequest())
           for autograph in autographs {
//               if let retrievedAutograph = autograph.autograph, let retrievedImage = autograph.image, let retrievedDate = autograph.date {
//                   let retrievedAutograph = Autograph(date: retrievedDate, image: UIImage(data: retrievedImage)!, autograph: UIImage(data: retrievedAutograph)!.withHorizontallyFlippedOrientation())
//
//                   let autographforCell = AutographCollectionCellViewModel(with: retrievedAutograph)
//                   print("\(autographforCell.date) ++")

                   self.delegate?.didUpdateUI(coreDataManager: self, autoGraph: autograph)

           }
       } catch {
           print(CoreDataManagerErrors.couldNotLoad.localizedDescription)
       }

   }

   func deleteAutograph(delete: AutographWithSignature){

       context.delete(delete)
       do {
           try context.save()
           DispatchQueue.main.async {
               self.collectionVewGallery.tableViewGallery.reloadData()
               self.getAutographs()
           }
       } catch {
           print(CoreDataManagerErrors.couldNotdelete.localizedDescription)
       }
   }

}
