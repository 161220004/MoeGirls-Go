//
//  CoreDataManager.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/12/3.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {
    
    static let shared = CoreDataManager() // 实例
    
    // 拿到AppDelegate中创建的NSManagedObjectContext
    lazy var context: NSManagedObjectContext = {
        let context = ((UIApplication.shared.delegate) as! AppDelegate).context
        return context
    }()
    
    // 更新数据
    private func saveContext() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    // 增加数据
    func insertData(girlAnnotation: MoeGirlAnnotation) {
        let girlItem = NSEntityDescription.insertNewObject(forEntityName: "AnnoList", into: context) as! AnnoList
        girlItem.annoId = Int32(girlAnnotation.annoId)
        girlItem.girlId = Int32(girlAnnotation.girlId)
        girlItem.girlName = girlAnnotation.girlName
        girlItem.girlDescription = girlAnnotation.girlDescription
        girlItem.girlLatitude = girlAnnotation.coordinate.latitude
        girlItem.girlLongitude = girlAnnotation.coordinate.longitude
        saveContext()
    }
    
    // 获取特定数据
    func getByAnnoId(id: Int) -> [AnnoList] {
        let fetchRequest: NSFetchRequest = AnnoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "annoId == %@", Int32(id))
        do {
            let items: [AnnoList] = try context.fetch(fetchRequest)
            return items
        } catch {
            fatalError();
        }
    }

    // 获取全部数据
    func getAll() -> [AnnoList] {
        let fetchRequest: NSFetchRequest = AnnoList.fetchRequest()
        do {
            let items: [AnnoList] = try context.fetch(fetchRequest)
            return items
        } catch {
            fatalError();
        }
    }
    
    // 删除特定数据
    func deleteByAnnoId(id: Int) {
        let fetchRequest: NSFetchRequest = AnnoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "annoId == %@", Int32(id))
        do {
            let items: [AnnoList] = try context.fetch(fetchRequest)
            for it in items {
                context.delete(it)
            }
            saveContext()
        } catch {
            fatalError();
        }
    }
    
    // 删除全部数据
    func deleteAll() {
        let items = getAll()
        for it in items {
            context.delete(it)
        }
        saveContext()
    }
}
