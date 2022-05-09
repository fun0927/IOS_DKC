//
//  Enviroment.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/16.
//

import Foundation
import UIKit

struct Environment {
    static var FCM_TOKEN = ""
    
    static let BASE_URL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String
    static let DEVICE_ID = UIDevice.current.identifierForVendor!.uuidString
    static let OS_VERSION = UIDevice.current.systemVersion
    static var AUTHORIZATOIN = ""
    static let DB_PATH = NSSearchPathForDirectoriesInDomains(
        .documentDirectory, .userDomainMask, true
    ).first!
    static var IS_MANAGE = "0"
    static var USER_NAME = ""
    static var USER_DIV_CD = ""
    static var USER_DIV_NAME = ""
    static var SYS_LANG = Locale.current.languageCode
    static var USER_PRSN_CD = ""
    
}
