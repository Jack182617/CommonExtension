//
//  UIViewController+Extension.swift
//  CommonExtension/Users/o--o/Code/开源项目/YJModules/CommonExtension
//
//  Created by 袁杰 on 2022-12-04.
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

    //提示
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

    //提示选择
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

    //跳转到已安装的地图导航
    func checkAndGoNav(coordinate : CLLocationCoordinate2D,endPlace : String) {
        var maps = [[String:String]]()

        var iosMapDic = [String:String]()
        iosMapDic["title"] = "苹果地图"
        maps.append(iosMapDic)

        //百度地图
        if UIApplication.shared.canOpenURL(URL.init(string: "baidumap://")!){
            var baiduMapDic = [String:String]()
            baiduMapDic["title"] = "百度地图"
            let urlString = "baidumap://map/direction?origin={{我的位置}}&destination=latlng:\(coordinate.latitude),\(coordinate.longitude)|name=\(endPlace)&mode=driving&coord_type=gcj02"
            baiduMapDic["url"] = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            maps.append(baiduMapDic)
        }

        //高德地图
        if UIApplication.shared.canOpenURL(URL.init(string: "iosamap://")!){
            var gaodeMapDic = [String:String]()
            gaodeMapDic["title"] = "高德地图"
            let urlString = "iosamap://navi?sourceApplication=\("导航")&backScheme=\("com.fangyizhan.fyzC")&poiname=\(endPlace)&lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&dev=0&style=2"
            gaodeMapDic["url"] = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            maps.append(gaodeMapDic)
        }

        //谷歌地图
        if UIApplication.shared.canOpenURL(URL.init(string: "comgooglemaps://")!){
            var googleMapDic = [String:String]()
            googleMapDic["title"] = "谷歌地图"
            let urlString = "comgooglemaps://?x-source=\("导航")&x-success=\("com.fangyizhan.fyzC")&saddr=\(endPlace)&daddr=\(coordinate.latitude),\(coordinate.longitude)&directionsmode=driving"
            googleMapDic["url"] = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            maps.append(googleMapDic)
        }

        //腾讯地图
        if UIApplication.shared.canOpenURL(URL.init(string: "qqmap://")!){
            var qqMapDic = [String:String]()
            qqMapDic["title"] = "腾讯地图"
            let urlString = "qqmap://map/routeplan?from=我的位置&type=drive&tocoord=\(coordinate.latitude),\(coordinate.longitude)&to=\(endPlace)&coord_type=1&policy=0"
            qqMapDic["url"] = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            maps.append(qqMapDic)
        }

        let alertController = UIAlertController.init(title: "导航", message: "选择地图", preferredStyle: .actionSheet)
        for i in 0 ..< maps.count {
            let actTion = UIAlertAction.init(title: maps[i]["title"], style: .default, handler: { (act) in
                //跳转地图
                if 0 == i{
                    //苹果原生地图导航
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
        let canCelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(canCelAction)
        present(alertController, animated: true, completion: nil)

    }

    //读取本地plist文件
    func readLocalPlistWithName(plistName: String) -> NSArray{
        guard let path = Bundle.main.path(forResource: plistName, ofType: "plist") else { return NSArray.init() }
        return NSArray.init(contentsOfFile: path) ?? NSArray.init()

    }

    //把数据存储为plist文件  Array<Dictionary<String, Any>>
    func writeArrToPlist(plistArr: Array<Any>, plistName: String) {
        let cachePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let filePath = cachePath! + "/\(plistName).plist"
        (plistArr as NSArray).write(toFile: filePath, atomically: true)
    }

    //获取当前屏幕显示的viewcontroller
    func getCurrentVCFrom(rootVC:UIViewController) -> UIViewController {
        var currentVC = UIViewController()
        if let vc = currentVC.presentedViewController{
            // 视图是被presented出来的
            currentVC = vc
        }

        if rootVC.isKind(of: UITabBarController.self){
            // 根视图为UITabBarController
            currentVC = self.getCurrentVCFrom(rootVC: (rootVC as! UITabBarController).selectedViewController!)
        }else if rootVC.isKind(of: UINavigationController.self){
            // 根视图为UINavigationController
            currentVC = self.getCurrentVCFrom(rootVC: (rootVC as! UINavigationController).visibleViewController!)
        }else{
            // 根视图为非导航类
            currentVC = rootVC
        }

        return currentVC
    }

    //回到指定的controller
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

    //MARK:- 生成二维码
    func creatQRCodeImage(text: String, WH: CGFloat) -> UIImage{

        //创建滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        //还原滤镜的默认属性
        filter?.setDefaults()
        //设置需要生成二维码的数据
        filter?.setValue(text.data(using: String.Encoding.utf8), forKey: "inputMessage")
        //从滤镜中取出生成的图片
        let ciImage = filter?.outputImage
        //这个清晰度好
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

    //保存图片到本地
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
