//
//  UIViewController+Extension.swift
//  
//
//  Created by Jack on 2022-12-04.
//

import Foundation
import MapKit
import Photos

public typealias SureAlertClickBlock = (() -> ())?
public typealias SelectedIndexBlock = ((String,Int) -> ())?

public typealias SavePicToLoacalBlock = ((Bool) -> ())?

public extension UIViewController{
    final func pushViewController(viewContoller: UIViewController, animated:Bool) {
        self.navigationController?.pushViewController(viewContoller, animated: animated)
    }

    final func popViewController(animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
    }

    //
    final func showNoticeAlertView(title:String,message:String,leftStr:String,rightStr:String,sureAlertClickBlock:SureAlertClickBlock){
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: leftStr, style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: rightStr, style: .default, handler: {
            action in

            if nil != sureAlertClickBlock{
                sureAlertClickBlock!()
            }

        })

        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }

    //
    final func showSelectActionSheet(title:String,message:String,cancle:String,items:[String],selectedBlock:SelectedIndexBlock){
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
        for item in items {
            let actTion = UIAlertAction.init(title: item, style: .default, handler: { (act) in
                if nil != selectedBlock{
                    selectedBlock!(act.title!,items.firstIndex(of: act.title!)!)
                }
            })

            alertController.addAction(actTion)
        }
        let canCelAction = UIAlertAction.init(title: cancle, style: .cancel, handler: nil)
        alertController.addAction(canCelAction)
        present(alertController, animated: true, completion: nil)
    }

    // Jump to installed map navigation
    func checkAndGoNav(coordinate : CLLocationCoordinate2D,endPlace : String) {
        var maps = [[String:String]]()

        var iosMapDic = [String:String]()
        iosMapDic["title"] = "Apple Maps"
        maps.append(iosMapDic)

        // Baidu map
        if UIApplication.shared.canOpenURL(URL.init(string: "baidumap://")!){
            var baiduMapDic = [String:String]()
            baiduMapDic["title"] = "Baidu map"
            let urlString = "baidumap://map/direction?origin={{mine_location}}&destination=latlng:\(coordinate.latitude),\(coordinate.longitude)|name=\(endPlace)&mode=driving&coord_type=gcj02"
            baiduMapDic["url"] = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            maps.append(baiduMapDic)
        }

        // AMAP
        if UIApplication.shared.canOpenURL(URL.init(string: "iosamap://")!){
            var gaodeMapDic = [String:String]()
            gaodeMapDic["title"] = "AMAP"
            let urlString = "iosamap://navi?sourceApplication=\("navigation")&backScheme=\("bundle Id")&poiname=\(endPlace)&lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&dev=0&style=2"
            gaodeMapDic["url"] = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            maps.append(gaodeMapDic)
        }

        // Google Maps
        if UIApplication.shared.canOpenURL(URL.init(string: "comgooglemaps://")!){
            var googleMapDic = [String:String]()
            googleMapDic["title"] = "Google Maps"
            let urlString = "comgooglemaps://?x-source=\("navigation")&x-success=\("bundle Id")&saddr=\(endPlace)&daddr=\(coordinate.latitude),\(coordinate.longitude)&directionsmode=driving"
            googleMapDic["url"] = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            maps.append(googleMapDic)
        }

        // Tencent Maps
        if UIApplication.shared.canOpenURL(URL.init(string: "qqmap://")!){
            var qqMapDic = [String:String]()
            qqMapDic["title"] = "Tencent Maps"
            let urlString = "qqmap://map/routeplan?from=mine_loation&type=drive&tocoord=\(coordinate.latitude),\(coordinate.longitude)&to=\(endPlace)&coord_type=1&policy=0"
            qqMapDic["url"] = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            maps.append(qqMapDic)
        }

        let alertController = UIAlertController.init(title: "navigation", message: "selec map", preferredStyle: .actionSheet)
        for i in 0 ..< maps.count {
            let actTion = UIAlertAction.init(title: maps[i]["title"], style: .default, handler: { (act) in
                //
                if 0 == i{
                    // Apple native map navigation
                    let currentLocation =  MKMapItem.forCurrentLocation()
                    let toLocation = MKMapItem.init(placemark: MKPlacemark.init(coordinate: coordinate, addressDictionary: nil))
                    MKMapItem.openMaps(with: [currentLocation, toLocation],
                                       launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                                         MKLaunchOptionsShowsTrafficKey:true])

                }else{
                    UIApplication.shared.open(URL.init(string: maps[i]["url"]!)!, options: [:], completionHandler: nil)
                }
            })

            alertController.addAction(actTion)
        }
        let canCelAction = UIAlertAction.init(title: "cancel", style: .cancel, handler: nil)
        alertController.addAction(canCelAction)
        present(alertController, animated: true, completion: nil)

    }

    // Read local plist file
    func readLocalPlistWithName(plistName: String) -> NSArray{
        guard let path = Bundle.main.path(forResource: plistName, ofType: "plist") else { return NSArray.init() }
        return NSArray.init(contentsOfFile: path) ?? NSArray.init()

    }

    // Store data as plist file Array<Dictionary<String, Any>>
    func writeArrToPlist(plistArr: Array<Any>, plistName: String) {
        let cachePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let filePath = cachePath! + "/\(plistName).plist"
        (plistArr as NSArray).write(toFile: filePath, atomically: true)
    }

    // Obtain the viewcontroller displayed on the current screen
    func getCurrentVCFrom(rootVC:UIViewController) -> UIViewController {
        var currentVC = UIViewController()
        if let vc = currentVC.presentedViewController{
            // The view is presented
            currentVC = vc
        }

        if rootVC.isKind(of: UITabBarController.self){
            // The root view is UITabBarController
            currentVC = self.getCurrentVCFrom(rootVC: (rootVC as! UITabBarController).selectedViewController!)
        }else if rootVC.isKind(of: UINavigationController.self){
            // The root view is UINavigationController
            currentVC = self.getCurrentVCFrom(rootVC: (rootVC as! UINavigationController).visibleViewController!)
        }else{
            // The root view is a non navigation class
            currentVC = rootVC
        }

        return currentVC
    }

    // Return to the specified controller
    func popToTargetController(controllerType:UIViewController.Type) {
        let controArr = self.navigationController?.viewControllers
        if 0 < controArr!.count{
            for controller in controArr!{
                if controller.isKind(of: controllerType) {
                    self.navigationController?.popToViewController(controller, animated: true)
                }
            }
        }
    }

    //MARK:- Generate QR code
    func creatQRCodeImage(text: String, WH: CGFloat) -> UIImage{

        // Create a filter
        let filter = CIFilter(name: "CIQRCodeGenerator")
        // Restore the default attributes of the filter
        filter?.setDefaults()
        // Set the data that needs to generate a QR code
        filter?.setValue(text.data(using: String.Encoding.utf8), forKey: "inputMessage")
        // Remove the generated image from the filter
        let ciImage = filter?.outputImage
        // Better clarity
        let bgImage = createNonInterpolatedUIImageFormCIImage(image: ciImage!, size: WH)

        return bgImage
    }

    func createNonInterpolatedUIImageFormCIImage(image: CIImage, size: CGFloat) -> UIImage {

        let extent: CGRect = image.extent.integral
        let scale: CGFloat = min(size/extent.width, size/extent.height)

        let width = extent.width * scale
        let height = extent.height * scale
        let cs: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: 0)!

        let context = CIContext(options: nil)
        let bitmapImage: CGImage = context.createCGImage(image, from: extent)!

        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: scale, y: scale)
        bitmapRef.draw(bitmapImage, in: extent)
        let scaledImage: CGImage = bitmapRef.makeImage()!
        return UIImage(cgImage: scaledImage)
    }

    // Save Image to Local
    @objc func saveToLocal(localImg: UIImage,  resultBlock: SavePicToLoacalBlock) {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == PHAuthorizationStatus.restricted || status == PHAuthorizationStatus.denied{
            resultBlock!(false)
        }else{
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: localImg)
            }) { (isSuccess, error) in
                DispatchQueue.main.async {
                    if isSuccess{
                        resultBlock!(true)
                    }else{
                        resultBlock!(false)
                    }
                }

            }
        }

    }


}
