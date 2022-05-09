//
//  AppDelegate.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/15.
//

import UIKit
import GoogleMaps
import Firebase
import FirebaseMessaging
import UserNotifications
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    let gcmMessageIDKey = "gcm.message_id"
    let util = Util()
    
    let unc = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("didFinishLaunchingWithOptions")
        GMSServices.provideAPIKey("AIzaSyDROO5S_hoPp8QopWrYW95GuT3lBBo5rmQ")
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        if #available(iOS 10.0, *) {
            unc.delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            unc.requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        application.applicationIconBadgeNumber = 0;
        
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print("didReceiveRemoteNotification userInfo : \(userInfo)")
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
            
            application.applicationIconBadgeNumber = application.applicationIconBadgeNumber+1;
            print("application.applicationIconBadgeNumber: \(application.applicationIconBadgeNumber)")
        }
        
        // Print full message.
        print(userInfo)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("applicationDidBecomeActive")
        application.applicationIconBadgeNumber = 0;
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("didRegisterForRemoteNotificationsWithDeviceToken : \(deviceToken)")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("didFailToRegisterForRemoteNotificationsWithError")
    }
    
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print(userInfo)
        
        let ttlKr = userInfo["ttlKr"] as! String
        let bdKr = userInfo["bdKr"] as! String
        let ttlJpn = userInfo["ttlJpn"] as! String
        let bdJpn = userInfo["bdJpn"] as! String
        //        let p1 = userInfo["p1"] as! String
        //        let p2 = userInfo["p2"] as! String
        
        let content = UNMutableNotificationContent()
        if let SYS_LANG = Environment.SYS_LANG {
            if SYS_LANG == "ja" {
                content.title = ttlJpn
                content.body = bdJpn
            }else {
                content.title = ttlKr
                content.body = bdKr
            }
        }
        content.userInfo = userInfo
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        unc.add(request) { error in
            print(#function, error ?? "nil")
        }
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        moveToPage(userInfo: userInfo)
    }
    
    func moveToPage(userInfo: [AnyHashable: Any]){
        let pshTp = userInfo["pshTp"] as! String
        let sndGrp = userInfo["sndGrp"] as! String
        let p1 = userInfo["p1"] as! String
        let p2 = userInfo["p2"] as! String
        
        
        ApiService.request(
            router: RecvHistApi.infoUpdate(param: RecvHistInfoUpdateRequest(sndGrp: sndGrp)),
            success: { (response: ApiResponse<CodeListResponse>) in
            }) { (error) in
            }
        
        switch pshTp {
            
        case "1":
            //공지사항
            let vc = NoticeListViewController()
            vc.dvs = p1
            vc.dataNo = p2
            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: vc)
            
        case "2":
            //기기등록 요청
            let vc = RegistApprovalViewController()
            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: vc)
            
        case "3" :
            //개인정보 변경
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
            
        case "4" :
            //기기등록 승인
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: LoginViewController())
            
        case "11", "12", "14", "15" :
            //결재요청
            let vc = ApprovalWaitListViewController()
            vc.msgCd = p1
            vc.seqNo = p2
            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: vc)
            
        case "21", "22", "24", "25" :
            //결재완료
            let vc = ApprovalWaitListViewController()
            vc.msgCd = p1
            vc.seqNo = p2
            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: vc)
            
        case "31", "32", "34", "35" :
            //반려
            let vc = ApprovalWaitListViewController()
            vc.msgCd = p1
            vc.seqNo = p2
            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: vc)
            
        case "13", "23", "33":
            //지출결의서
            let vc = RecvHistViewController()
            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: vc)
            
        case "41":
            //근무계획 미작성
            let vc = WorkingPlanViewController()
            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: vc)
            
        case "43":
            //업무일지 미작성
            let vc = WorkReportListViewController()
            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: vc)
            
        case "51", "52", "53", "54", "55":
            //초과근로
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
            
        case "56":
            //초과근로 종합
            let vc = WorkOverViewController()
            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: vc)
            
        case "61":
            //증명서 발급 승인 요청
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
            
        case "62":
            //증명서 발급 승인
            let vc = CertificateViewController()
            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: vc)
            
        case "63":
            //법인카드 및 접대비 승인 요청
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
            
        case "64", "66":
            //법인카드 승인, 접대비 승인
            let vc = CardViewController()
            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: vc)
            
        case "71":
            //인사발령 요청
            let vc = HumanListViewController()
            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: vc)
            
        case "72", "73":
            //인사발령 승인, 인사발령 승인취소
            let vc = RecvHistViewController()
            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: vc)
            
        default:
            let vc = RecvHistViewController()
            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: vc)
        }
        
        // EX : console에서 호출 한 푸쉬 얼럿 터치 시 공지사항으로 이동하는 코드
        //        let defaults: UserDefaults = UserDefaults.standard
        //        defaults.set("사내공지사항", forKey: "viewControllwer")
        //        // integer로 저장하면 키 지웠을 때에도 0으로 반환
        //        defaults.set("3", forKey: "listIndex")
        //        defaults.synchronize()
        //        print("moveToPage called")
        //        if let getVc = util.getViewControllerFromText(label: "사내공지사항") {
        //            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: getVc)
        //        }
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    //    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    //        let userInfo = notification.request.content.userInfo
    //        // With swizzling disabled you must let Messaging know about the message, for Analytics
    //        // Messaging.messaging().appDidReceiveMessage(userInfo)
    //
    //        // ...
    //
    //        // Print full message.
    //        let dict = userInfo as! [String: Any]
    //        print("dict : \(dict)")
    //        do {
    //
    //        } catch  {
    //            print(error)
    //        }
    //    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let fcmToken = fcmToken {
            print("Firebase registration token: \(fcmToken)")
            let dataDict:[String: String] = ["token": fcmToken]
            NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        }
    }
}
