//
//  DrawingViewModel.swift
//  GhostDrawingBoard
//
//  Created by Raj Rathod on 09/10/23.
//

import UIKit

class DrawingViewModel {
    var currentColor: DrawingTool = .red
    private var drawingStrokes: [DrawingStroke] = []

    // Function to change the current drawing color
    func selectColor(_ color: DrawingTool) {
        currentColor = color
    }
    
    // Function to handle eraser selection
    func selectEraser() {
        currentColor = .eraser
    }
    
    // Function to get drawing stoke
    func getDrawingStroke(path: UIBezierPath) -> DrawingStroke {
        let drawingStroke = DrawingStroke(path: path, color: currentColor)
        return drawingStroke
    }
    
    // Function to handle a user's drawing stroke
    func handleDrawing(_ drawingStroke: DrawingStroke) {
        drawingStrokes.append(drawingStroke)
    }

    // Function to get the drawing strokes for a specific color with a delay
    func getGhostStrokes(for color: DrawingTool, withDelay delay: TimeInterval, completion: @escaping ([DrawingStroke]) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
            completion(self.drawingStrokes)
        }
    }
    
    func clearDrawing(completion: @escaping ([DrawingStroke]) -> Void) {
        drawingStrokes.removeAll()
        completion(drawingStrokes)
    }
}
