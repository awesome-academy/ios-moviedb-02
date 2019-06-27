//
//  RealmRepositoyManagement.swift
//  MovieDB
//
//  Created by cuonghx on 6/26/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import RealmSwift
import RxRealm

// swiftlint:disable force_try
struct RealmManager {
    
    static let sharedInstance = RealmManager()
    private var realm: Realm
    
    private init() {
        realm = try! Realm()
    }
    
    func getAllData<T: Object>() -> Observable<[T]> {
        let object = realm.objects(T.self).sorted(byKeyPath: "addDate", ascending: false)
        return Observable.collection(from: object).map {
            $0.toArray()
        }
    }
    
    func addData<T: Object> (item: T) -> Observable<T> {
        do {
            try realm.write {
                realm.add(item)
            }
            return .just(item)
        } catch {
            return .error(RealmError.addFail)
        }
    }
    
    func deleteData<T: Object>(item: T) -> Observable<Bool> {
        do {
            guard let primaryKey = T.primaryKey(),
                let primaryValue = item.value(forKey: primaryKey) as? Int,
                let object = realm.object(ofType: Movie.self,
                                          forPrimaryKey: primaryValue) else {
                                            return .just(true)
            }
            try realm.write {
                realm.delete(object)
            }
            return .just(false)
        } catch {
            return .error(RealmError.deleteFail)
        }
    }
    
    func checkItemExist(item: Movie) -> Bool {
        guard realm.object(ofType: Movie.self,
                           forPrimaryKey: item.id) != nil else {
                                            return false
        }
        return true
    }
}
