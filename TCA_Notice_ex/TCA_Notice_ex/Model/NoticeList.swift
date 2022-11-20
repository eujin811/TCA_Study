//
//  NoticeList.swift
//  TCA_Notice_ex
//
//  Created by YoujinMac on 2022/11/20.
//

import Foundation

struct NoticeList: Decodable {
    let code: Int
    let list: [NoticeItem]
    
    init(frome decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(Int.self, forKey: .code)
        self.list = (try? container.decode([NoticeItem].self, forKey: .list)) ?? [NoticeItem]()
    }
    
    struct NoticeItem: Decodable {
        let id: Int
        let title: String
        let dateTime: String
        
        private enum CodingKeys: String, CodingKey {
            case id, title
            case dateTime = "datetime"
        }
        
        init(frome decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let id = try container.decode(String.self, forKey: .id)
            let date = (try? container.decode(String.self, forKey: .dateTime))?
                .toDate(dateFormat: .yyyyMMddHHmmssSSS)
            
            self.id = Int(id) ?? -1
            self.title = (try? container.decode(String.self, forKey: .title)) ?? String()
            self.dateTime = date?.toString(dateFormat: .yyyyMMddD) ?? String()
        }
    }
}
