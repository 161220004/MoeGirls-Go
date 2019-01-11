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
    
    // MARK: - Player Manager ######################################################
    
    // 增加玩家
    func insertPlayer(player: Player) {
        let playerItem = NSEntityDescription.insertNewObject(forEntityName: "PlayerList", into: context) as! PlayerList
        playerItem.no = Int32(player.no)
        playerItem.name = player.name
        playerItem.head = 0 // 默认头像为0号
        saveContext()
    }
    
    // 获取特定数据
    func getPlayerByNo(playerNo: Int) -> [PlayerList] {
        let fetchRequest: NSFetchRequest = PlayerList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "no == %d", playerNo)
        do {
            let items: [PlayerList] = try context.fetch(fetchRequest)
            return items
        } catch {
            print("获取数据失败")
            fatalError();
        }
    }

    // 获得全部玩家
    func getAllPlayers() -> [PlayerList] {
        let fetchRequest: NSFetchRequest = PlayerList.fetchRequest()
        do {
            let items: [PlayerList] = try context.fetch(fetchRequest)
            return items
        } catch {
            print("获取数据失败")
            fatalError();
        }
    }
    
    // 删除玩家
    func deletePlayer(playerNo: Int) {
        let items = getPlayerByNo(playerNo: playerNo)
        for it in items {
            context.delete(it)
        }
        saveContext()
    }
    
    // 修改玩家数据
    func updatePlayer(player: Player) {
        let fetchRequest: NSFetchRequest = PlayerList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "playerNo == %d", player.no)
        do {
            let items: [PlayerList] = try context.fetch(fetchRequest)
            for it in items {
                it.name = player.name
                it.head = Int32(player.hid)
            }
        } catch {
            fatalError();
        }
        saveContext()
    }
    
    // 加载全部玩家数据到临时数组
    func loadAllPlayers() {
        // 先清空原数组
        players.removeAll()
        let items = getAllPlayers()
        for it in items {
            // 从数据库获取一个玩家数据
            let player = Player()
            player.setNo(playerNo: PlayerRange(rawValue: Int(it.no))!)
            player.setName(playerName: it.name!)
            player.setHead(headId: HeadRange(rawValue: Int(it.head))!)
            players.append(player) // 添加到玩家数组
        }
    }
    
    // MARK: - AnnoList Manager ######################################################
    
    // 增加数据
    func insertAnnotation(girlAnnotation: MoeGirlAnnotation) {
        let girlItem = NSEntityDescription.insertNewObject(forEntityName: "AnnoList", into: context) as! AnnoList
        girlItem.playerNo = Int32(currentPlayer.no)
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
        fetchRequest.predicate = NSPredicate(format: "(playerNo == %d) AND (annoId == %d)", currentPlayer.no, id)
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
        fetchRequest.predicate = NSPredicate(format: "playerNo == %d", currentPlayer.no)
        do {
            let items: [AnnoList] = try context.fetch(fetchRequest)
            return items
        } catch {
            print("获取数据失败")
            fatalError();
        }
    }
    
    // 删除特定数据
    func deleteAnnotationById(id: Int) {
        let fetchRequest: NSFetchRequest = AnnoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "(playerNo == %d) AND (annoId == %d)", currentPlayer.no, id)
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
        // 先清空原字典
        girlAnnotations.removeAll()
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
        girlItem.playerNo = Int32(currentPlayer.no)
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
        fetchRequest.predicate = NSPredicate(format: "playerNo == %d", currentPlayer.no)
        do {
            let items: [BookList] = try context.fetch(fetchRequest)
            return items
        } catch {
            print("获取数据失败")
            fatalError();
        }
    }
    
    // 在应用的最初，初始化数据
    func initBook() {
        let items = getAllInformation()
        // 若应用下载以来，已经初始化过数据了，则直接返回
        if items.count > 0 {
            return
        }
        // 否则初始化为默认值
        for i in 1...MoeGirlTypeNum {
            insertInformation(girlInformation: MoeGirlInformation(id: i))
        }
    }
    
    // 修改数据
    func updateInformation(girlInformation: MoeGirlInformation) {
        let fetchRequest: NSFetchRequest = BookList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "(playerNo == %d) AND (girlId == %d)", currentPlayer.no, girlInformation.girlId)
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
    
    // 删除全部数据
    func deleteBook() {
        let items = getAllInformation()
        for it in items {
            context.delete(it)
        }
        saveContext()
    }
    
    // 加载全部数据到临时字典
    func loadBook() {
        // 先清空原字典
        girlBook.removeAll()
        let items = getAllInformation()
        for it in items {
            // 从数据库获取一个图鉴中的数据
            let infoMoeGirl = MoeGirlInformation(id: Int(it.girlId))
            infoMoeGirl.setFix(enc: it.encountered, encDate: it.encounterDate!,
                               favLev: Int(it.favorLevel), favPct: Int(it.favorExpPercent))
            girlBook[Int(it.girlId)] = infoMoeGirl // 添加到图鉴字典
        }
    }
    
    // MARK: - Achievement Manager ######################################################
    
    // 更新保存成就数据到数据库
    func updateAchievement() {
        let fetchRequest: NSFetchRequest = AchievementList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "playerNo == %d", currentPlayer.no)
        do {
            let items: [AchievementList] = try context.fetch(fetchRequest)
            // 若没有则加上
            if items.count == 0 {
                let achievementItem = NSEntityDescription.insertNewObject(forEntityName: "AchievementList", into: context) as! AchievementList
                achievementItem.encounterNum = Int32(totalEncounterNum)
            }
            else { // 有则直接保存
                items[0].encounterNum = Int32(totalEncounterNum)
            }
        } catch {
            fatalError();
        }
        saveContext()
    }
    
    // 加载成就数据到临时变量totalEncounterNum
    func loadAchievement() {
        let fetchRequest: NSFetchRequest = AchievementList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "playerNo == %d", currentPlayer.no)
        do {
            let items: [AchievementList] = try context.fetch(fetchRequest)
            // 首次加载，则先向数据库写入一个0，并且得出邂逅次数为0
            if items.count == 0 {
                totalEncounterNum = 0
                let achievementItem = NSEntityDescription.insertNewObject(forEntityName: "AchievementList", into: context) as! AchievementList
                achievementItem.playerNo = Int32(currentPlayer.no)
                achievementItem.encounterNum = 0
                saveContext()
            }
            else { // 否则取出其中存储的数据
                totalEncounterNum = Int(items[0].encounterNum)
            }
        } catch {
            print("获取数据失败")
            fatalError();
        }
    }
    
    // 删除成就数据
    func deleteAchievement() {
        let fetchRequest: NSFetchRequest = AchievementList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "playerNo == %d", currentPlayer.no)
        do {
            let items: [AchievementList] = try context.fetch(fetchRequest)
            if items.count != 0 {
                context.delete(items[0])
            }
        } catch {
            print("获取数据失败")
            fatalError();
        }
        saveContext()
    }
}
