//
//  SlideMenuModel.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/21.
//

import Foundation
import UIKit

struct SlideMenuModel {
    var menu: [SlideMenu] = [
        SlideMenu(depth1: "출퇴근정보".localized, deptth2: [
            Util.ShortCutContent(editIcon: UIImage(named: "editTimer")!, mainIcon: UIImage(named: "mainTimer")!, title: "월별 출퇴근 현황".localized, pgmId: "P0001")
        ]),
        SlideMenu(depth1: "근무계획정보".localized, deptth2: [
            Util.ShortCutContent(editIcon: UIImage(named: "edit-date")!, mainIcon: UIImage(named: "main-date")!, title: "근무 계획 등록".localized, pgmId: "W1001A"),
            Util.ShortCutContent(editIcon: UIImage(named: "edit-date")!, mainIcon: UIImage(named: "main-pie-chart")!, title: "나의 근무 현황".localized, pgmId: "W1002A")
        ]),
        SlideMenu(depth1: "업무관리".localized, deptth2: [
            Util.ShortCutContent(editIcon: UIImage(named: "edit-circle-plus-outline")!, mainIcon: UIImage(named: "main-circle-plus-outline")!, title: "확인원 등록".localized, pgmId: "W2002A"), //G101014N
            Util.ShortCutContent(editIcon: UIImage(named: "edit-document-add")!, mainIcon: UIImage(named: "main-document-add")!, title: "업무 일지 등록".localized, pgmId:"W2003A"), // G101016B
            Util.ShortCutContent(editIcon: UIImage(named: "edit-edit-outline")!, mainIcon: UIImage(named: "main-edit-outline")!, title: "증명서 발급 신청".localized, pgmId: "W2004A"), //
            Util.ShortCutContent(editIcon: UIImage(named: "edit-bank-card")!, mainIcon: UIImage(named: "main-bank-card")!, title: "법인카드 및 접대비 사전신청".localized, pgmId: "W2005A")
        ]),
        SlideMenu(depth1: "결재관리".localized, deptth2: [
            Util.ShortCutContent(editIcon: UIImage(named: "edit-tickets")!, mainIcon: UIImage(named: "main-tickets")!, title: "전자 결재함".localized, pgmId: "W2001Q")
        ]),
        SlideMenu(depth1: "근무현황".localized, deptth2: [
            Util.ShortCutContent(editIcon: UIImage(named: "edit-data-analysis")!, mainIcon: UIImage(named: "main-data-analysis")!, title: "근무 계획 현황".localized, pgmId: "W1006Q"), // E901004Q
            Util.ShortCutContent(editIcon: UIImage(named: "edit-data-line")!, mainIcon: UIImage(named: "main-data-line")!, title: "월별 초과 근로 현황".localized, pgmId: "W1005Q"), //E901003Q
            Util.ShortCutContent(editIcon: UIImage(named: "edit-folder-checked")!, mainIcon: UIImage(named: "main-folder-checked")!, title: "근무 계획 실적 현황".localized, pgmId: "W1003Q")
        ]),
        SlideMenu(depth1: "설문조사".localized, deptth2: [
            Util.ShortCutContent(editIcon: UIImage(named: "edit-files")!, mainIcon: UIImage(named: "main-files")!, title: "설문조사".localized)
        ]),
        SlideMenu(depth1: "공지사항".localized, deptth2: [
            Util.ShortCutContent(editIcon: UIImage(named: "edit-chat-dot-round")!, mainIcon: UIImage(named: "main-chat-dot-round")!, title: "사내공지사항".localized),
            Util.ShortCutContent(editIcon: UIImage(named: "edit-first-aid-kit")!, mainIcon: UIImage(named: "main-first-aid-kit")!, title: "안전공지사항".localized),
            Util.ShortCutContent(editIcon: UIImage(named: "edit-finished")!, mainIcon: UIImage(named: "main-finished")!, title: "노동조합공지사항".localized, pgmId: "W0001Q")
        ]),
        SlideMenu(depth1: "메시지관리".localized, deptth2: [
            Util.ShortCutContent(editIcon: UIImage(named: "edit-message")!, mainIcon: UIImage(named: "main-message")!, title: "메시지 발송".localized, pgmId: "W8001A"), // BB001A
            Util.ShortCutContent(editIcon: UIImage(named: "edit-document-copy")!, mainIcon: UIImage(named: "main-document-copy")!, title: "메시지 발송 이력현황".localized, pgmId: "W8002Q"), // BB002Q
            Util.ShortCutContent(editIcon: UIImage(named: "edit-bell")!, mainIcon: UIImage(named: "main-bell")!, title: "알림확인".localized)
        ]),
        SlideMenu(depth1: "기준정보".localized, deptth2: [
            Util.ShortCutContent(editIcon: UIImage(named: "edit-set-up")!, mainIcon: UIImage(named: "main-set-up")!, title: "출퇴근 정보 관리".localized, pgmId: "W7002A"), // BM005A
            Util.ShortCutContent(editIcon: UIImage(named: "edit-finished")!, mainIcon: UIImage(named: "main-finished")!, title: "메시지 설정".localized, pgmId: "W7001A"), // BM001A
        ]),
        SlideMenu(depth1: "권한관리".localized, deptth2: [
            Util.ShortCutContent(editIcon: UIImage(named: "edit-unlock")!, mainIcon: UIImage(named: "main-unlock")!, title: "권한관리".localized, pgmId: "W6001A"), //BS009A,
            Util.ShortCutContent(editIcon: UIImage(named: "edit-mobile-phone")!, mainIcon: UIImage(named: "main-mobile-phone")!, title: "기기등록 승인".localized, pgmId: "W6002A"), // BS100A
        ])
    ]
}

struct SlideMenu {
    var isCollapsible = false
    var depth1: String
    var deptth2: [Util.ShortCutContent]
}

