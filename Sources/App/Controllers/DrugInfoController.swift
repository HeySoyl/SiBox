//
//  DrugInfoController.swift
//  App
//
//  Created by Soyl on 2020/2/28.
//

import Vapor
import FluentPostgreSQL

class DrugInfoController: RouteCollection {
    
    let GetSuccess = "查询成功"
    let GetFailed = "查询失败"
    let SaveSuccess = "保存成功"
    let SaveFailed = "保存失败"
    let IdNotNil = "ID不能为空"
    let DeleteSuccess = "删除成功"
    let NoID = "ID不存在"
    
    // 定义接口名称
    func boot(router: Router) throws {
        router.group("drug"){ group in
            group.post("select", use: self.select)
            group.post("selectAll", use: self.selectAll)
            group.post("create", use: self.create)
            group.patch("update", use: self.update)
            group.delete("delete", use: self.delete)
        }
    }
    
    func select(_ req: Request) throws -> Future<Response>{
//        return try req.content.decode(DrugInfo.self).flatMap { drugInfoes in
            return DrugInfo.query(on: req)
                .all()
                .flatMap({  content in
                    return try ResponseJSON<[DrugInfo]>(status: 0, message: self.GetSuccess, data: content).encode(for: req)
                })
//        }
    }
    func selectAll(_ req: Request) throws -> Future<Response>{
        return try req.content.decode(DrugInfo.self).flatMap { drugInfoes in
            return DrugInfo.query(on: req)
                .all()
                .flatMap({  content in
                    return try ResponseJSON<[DrugInfo]>(status: 0, message: self.GetSuccess, data: content).encode(for: req)
                })
        }
    }
    func create(_ req: Request) throws -> Future<Response>{
        return try req.content.decode(DrugInfo.self).flatMap { drugInfoes in
            return drugInfoes.save(on: req)
                .flatMap({  content in
                    return try ResponseJSON<[Empty]>(status: 0, message: self.SaveSuccess).encode(for: req)
                })
        }
    }
    func update(_ req: Request) throws -> Future<Response>{
        return try req.content.decode(DrugInfo.self).flatMap { drugInfoes in
            if drugInfoes.id == nil {
                return try ResponseJSON<[Empty]>(status: 1021, message: self.IdNotNil).encode(for: req)
            } else {
                return drugInfoes.update(on: req, originalID: drugInfoes.id).flatMap({  content in
                    return try ResponseJSON<[Empty]>(status: 0, message: self.SaveSuccess).encode(for: req)
                })
            }
        }
    }
    func delete(_ req: Request) throws -> Future<Response>{
        return try req.content.decode(DrugInfo.self).flatMap { drugInfoes in
            
            guard drugInfoes.id != nil else {
                return try ResponseJSON<[Empty]>(status: 1021, message: self.IdNotNil).encode(for: req)
            }
            
            return DrugInfo.query(on: req)
                .filter(\.id == drugInfoes.id)
                .first()
                .flatMap({  content in
                    if content == nil {
                        return try ResponseJSON<[Empty]>(status: 1022, message: self.NoID).encode(for: req)
                    } else {
                        return drugInfoes.delete(on: req)
                            .flatMap({  cont in
                                return try ResponseJSON<[Empty]>(status: 0, message: self.DeleteSuccess).encode(for: req)
                            })
                    }
                })
        }
    }
}
