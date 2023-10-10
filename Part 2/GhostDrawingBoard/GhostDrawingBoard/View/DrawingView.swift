//
//  DrawingView.swift
//  GhostDrawingBoard
//
//  Created by Raj Rathod on 09/10/23.
//

import UIKit

protocol DrawingViewDelegate: AnyObject {
    func didEndDrawing(_ drawingStroke: DrawingStroke)
}

class DrawingView: UIView {

    private var currentPath: UIBezierPath?
    private var currentPoint: CGPoint?
    var drawingStrokes: [DrawingStroke] = []
    var viewModel: DrawingViewModel?
    weak var delegate: DrawingViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        // Add a border
        layer.borderWidth = 1.0 // Adjust the border width as needed
        layer.borderColor = UIColor.lightGray.cgColor // Set the border color
        
        // Add rounded corners
        layer.cornerRadius = 10.0 // Adjust the corner radius as needed
        layer.masksToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentPath = UIBezierPath()
        currentPath?.lineWidth = 5.0
        currentPath?.lineCapStyle = .round
        currentPath?.lineJoinStyle = .round

        let touch = touches.first!
        currentPoint = touch.location(in: self)
        currentPath?.move(to: currentPoint!)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let point = touch.location(in: self)

        currentPath?.addLine(to: point)
        currentPoint = point
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let path = currentPath {
            guard let drawingStroke = viewModel?.getDrawingStroke(path: path) else { return }
            delegate?.didEndDrawing(drawingStroke)
        }

        currentPath = nil
        currentPoint = nil
    }

    override func draw(_ rect: CGRect) {
        for stroke in drawingStrokes {
            stroke.color.uiColor.setStroke()
            stroke.path.stroke()
        }

        viewModel?.currentColor.uiColor.setStroke()
        currentPath?.stroke()
    }
}
