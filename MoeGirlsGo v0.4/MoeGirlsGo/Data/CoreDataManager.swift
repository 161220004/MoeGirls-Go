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
    
    // MARK: - AnnoList Manager ######################################################
    
    // 增加数据
    func insertAnnotation(girlAnnotation: MoeGirlAnnotation) {
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
    func getAnnotationById(id: Int) -> [AnnoList] {
        let fetchRequest: NSFetchRequest = AnnoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "annoId == %d", id)
        do {
            let items: [AnnoList] = try context.fetch(fetchRequest)
            return items
        } catch {
            print("获取数据失败")
            fatalError();
        }
    }

    // 获取全部数据
    func getAllAnnotations() -> [AnnoList] {
        let fetchRequest: NSFetchRequest = AnnoList.fetchRequest()
        do {
            let items: [AnnoList] = try context.fetch(fetchRequest)
            return items
        } catch {
            fatalError();
        }
    }
    
    // 删除特定数据
    func deleteAnnotationById(id: Int) {
        let fetchRequest: NSFetchRequest = AnnoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "annoId == %d", id)
        do {
            let items: [AnnoList] = try context.fetch(fetchRequest)
            for it in items {
                context.delete(it)
            }
        } catch {
            print("删除数据失败")
            fatalError();
        }
        saveContext()
    }
    
    // 删除全部数据
    func deleteAllAnnotations() {
        let items = getAllAnnotations()
        for it in items {
            context.delete(it)
        }
        saveContext()
    }
    
    // 加载全部数据到临时字典
    func loadAllAnnotations() {
        let items = getAllAnnotations()
        for it in items {
            // 从数据库获取一个标注的值
            let annoMoeGirl = MoeGirlAnnotation()
            annoMoeGirl.setFix(aId: Int(it.annoId), gId: Int(it.girlId),
                               name: it.girlName!, desc: it.girlDescription!,
                               location: CLLocationCoordinate2D(latitude: it.girlLatitude,
                                                                longitude: it.girlLongitude))
            girlAnnotations[Int(it.annoId)] = annoMoeGirl // 添加到地图标注字典
        }
    }
    
    // MARK: - BookList Manager ######################################################
    
    // 增加数据
    private func insertInformation(girlInformation: MoeGirlInformation) {
        let girlItem = NSEntityDescription.insertNewObject(forEntityName: "BookList", into: context) as! BookList
        girlItem.girlId = Int32(girlInformation.girlId)
        girlItem.encountered = girlInformation.encountered
        girlItem.encounterDate = girlInformation.encounterDate
        girlItem.favorLevel = Int32(girlInformation.favorLevel)
        girlItem.favorExpPercent = Int32(girlInformation.favorExpPercent)
        saveContext()
    }
    
    // 获取全部数据
    func getAllInformation() -> [BookList] {
        let fetchRequest: NSFetchRequest = BookList.fetchRequest()
        do {
            let items: [BookList] = try context.fetch(fetchRequest)
            return items
        } catch {
            fatalError();
        }
    }
    
    // 在应用的最初，初始化数据
    func initBook() {
        let items = getAllInformation()
        if items.count > 0 { // 应用下载以来，已经初始化过数据了
            return
        }
        for i in 1...MoeGirlTypeNum {
            insertInformation(girlInformation: MoeGirlInformation(id: i))
        }
    }
    
    // 修改数据
    func updateInformation(girlInformation: MoeGirlInformation) {
        let fetchRequest: NSFetchRequest = BookList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "girlId == %d", girlInformation.girlId)
        do {
            let items: [BookList] = try context.fetch(fetchRequest)
            for it in items {
                it.encountered = girlInformation.encountered
                it.encounterDate = girlInformation.encounterDate
                it.favorLevel = Int32(girlInformation.favorLevel)
                it.favorExpPercent = Int32(girlInformation.favorExpPercent)
            }
        } catch {
            fatalError();
        }
        saveContext()
    }
    
    // 加载全部数据到临时字典
    func loadBook() {
        let items = getAllInformation()
        for it in items {
            // 从数据库获取一个图鉴中的数据
            let infoMoeGirl = MoeGirlInformation(id: Int(it.girlId))
            infoMoeGirl.setFix(enc: it.encountered, encDate: it.encounterDate!,
                               favLev: Int(it.favorLevel), favPct: Int(it.favorExpPercent))
            girlBook[Int(it.girlId)] = infoMoeGirl // 添加到图鉴字典
        }
    }
}
