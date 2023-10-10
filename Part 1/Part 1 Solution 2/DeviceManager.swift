//
//  DeviceManager.swift
//  DilTestPartOne
//
//  Created by Raj Rathod on 10/10/23.
//

import UIKit

/// DeviceManager is to maake code more modular
/// The DeviceManager class is defined to encapsulate device-related logic.
class DeviceManager {
    static func isIPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
