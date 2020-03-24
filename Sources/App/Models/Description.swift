//
//  Description.swift
//  App
//
//  Created by Soyl on 2020/3/24.
//

import FluentPostgreSQL
import Fluent
import Foundation
import Vapor

/// A single entry of a DrugInfo list.
final class Description: Content, PostgreSQLModel {
    
    /// The unique identifier for this `DrugInfo`
    typealias ID = Int
    static let idKey: IDKey = \.id
    
    var id: Int?
    var name: String?               //药品名称 - 通用
    var nameEN: String?             //药品名称 - 英文名称
    var namePY: String?             //药品名称 - 中文拼音
    var componentcs: String?        //成分
    var characteristics: String?    //性状
    var useCategory: String?        //作用类别
    var adaptation: String?         //适应症/功能主治
    var specification: String?      //规格
    var useMethods: String?         //用法用量
    var adverse: String?            //禁忌
    var attention: String?          //注意事项
    var drugs: String?              //药物相互作用
    var pharmacology: String?       //药理相互作用（西）
    var storage: String?            //储藏
    var packing: String?            //包装
    var validity: String?           //有效期
    var standards: String?          //执行标准
    var approval: String?           //批准文号
    var updateDate: String?           //说明书修订日期
    var company: String?            //生产企业 - 企业名称
    var proAds: String?             //生产地址
    var posCode: String?            //邮政编码
    var phoneNum: String?           //电话号码
    var faxNum: String?             //传真号码
    var regAds: String?             //注册地址
    var busUrl: String?             //网址
    var uuid: UUID?

    /// Creates a new `DrugInfo`.
    init(id: Int? = nil, name: String?, nameEN: String?, namePY: String?, componentcs: String?, characteristics: String?, useCategory: String?, adaptation: String?, specification: String?, useMethods: String?, attention: String?, drugs: String?, pharmacology: String?, storage: String?, packing: String?, validity: String?, standards: String?, approval: String?, updateDate: String?, company: String?, proAds: String?, posCode: String?, phoneNum: String?, faxNum: String?, regAds: String?, busUrl: String?, uuid: UUID? = nil) {
        self.id = id
        self.name = name
        self.nameEN = nameEN
        self.namePY = namePY
        self.componentcs = componentcs
        self.characteristics = characteristics
        self.useCategory = useCategory
        self.adaptation = adaptation
        self.specification = specification
        self.useMethods = useMethods
        self.attention = attention
        self.drugs = drugs
        self.pharmacology = pharmacology
        self.storage = storage
        self.packing = packing
        self.validity = validity
        self.standards = standards
        self.approval = approval
        self.updateDate = updateDate
        self.company = company
        self.proAds = proAds
        self.posCode = posCode
        self.phoneNum = phoneNum
        self.faxNum = faxNum
        self.regAds = regAds
        self.busUrl = busUrl
        self.uuid = UUID()
    }
}

///// Allows `DrugInfo` to be used as a dynamic migration.
//extension DrugInfo: Migration { }

/// Allows `DrugInfo` to be encoded to and decoded from HTTP messages.
//extension DrugInfo: Content { }

/// Allows `DrugInfo` to be used as a dynamic parameter in route definitions.
extension Description: Parameter { }
