//
//  DispatchQueue+Extension.swift
//  
//
//  Created by Jack on 2022-12-04.
//

import Foundation

public extension DispatchQueue {
    private static var _onceToken = [String]()

    class func once(token: String = "\(#file):\(#function):\( #line)", block: (()->())) {
        objc_sync_enter(self)

        defer {
            objc_sync_exit(self)
        }

        if _onceToken.contains(token) {
            return
        }
        _onceToken.append(token)
        block()
    }

    typealias CancelTask = (_ cancel: Bool) -> Void
    /// 
    func delay(_ time: TimeInterval, task: @escaping () -> ()) -> CancelTask? {
        func dispatch_later(block: @escaping () -> ()) {
            let t = DispatchTime.now() + time
            DispatchQueue.main.asyncAfter(deadline: t, execute: block)
        }

        var closure: (() -> Void)? = task
        var result: CancelTask?

        let delayedClosure: CancelTask = { cancel in
            if let internalClosure = closure {
                if (cancel == false) {
                    DispatchQueue.main.async(execute: internalClosure)
                }
            }
            closure = nil
            result = nil
        }

        result = delayedClosure
        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(false)
            }
        }

        return result
    }

    func cancel(_ task: CancelTask?) {
        task?(true)
    }
}
