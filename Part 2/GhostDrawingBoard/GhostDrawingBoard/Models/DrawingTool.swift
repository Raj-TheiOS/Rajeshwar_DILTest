//
//  DrawingColor.swift
//  GhostDrawingBoard
//
//  Created by Raj Rathod on 10/10/23.
//

import UIKit

// Enum to represent drawing colors
enum DrawingTool {
    case red
    case green
    case blue
    case eraser
    
    var ghostDrawingDelay: TimeInterval {
        switch self {
        case .red: return 1.0
        case .blue: return 3.0
        case .green: return 5.0
        case .eraser: return 2.0
        }
    }
    
    var uiColor: UIColor {
         switch self {
         case .red: return UIColor.red
         case .blue: return UIColor.blue
         case .green: return UIColor.green
         case .eraser: return UIColor.white
         }
     }

}
