//
//  ViewController.swift
//  GhostDrawingBoard
//
//  Created by Raj Rathod on 09/10/23.
//

import UIKit

class DrawingViewController: UIViewController {
    
    @IBOutlet weak var drawingView: DrawingView!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var eraserButton: UIButton!
    
    // Create an instance of the DrawingViewModel
    let viewModel = DrawingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign the viewModel to the DrawingView
        drawingView.viewModel = viewModel

        // Set up button actions
        setupUI()
        drawingView.delegate = self
    }
    
    func setupUI() {
        redButton.addTarget(self, action: #selector(selectRedColor), for: .touchUpInside)
        blueButton.addTarget(self, action: #selector(selectBlueColor), for: .touchUpInside)
        greenButton.addTarget(self, action: #selector(selectGreenColor), for: .touchUpInside)
        eraserButton.addTarget(self, action: #selector(selectEraser), for: .touchUpInside)
    }
    
    // Button actions
    @objc func selectRedColor() {
        viewModel.selectColor(.red)
    }
    
    @objc func selectBlueColor() {
        viewModel.selectColor(.blue)
    }
    
    @objc func selectGreenColor() {
        viewModel.selectColor(.green)
    }
    
    @objc func selectEraser() {
        viewModel.selectEraser()
    }
    
    @IBAction func clearDrawing(_ sender: UIBarButtonItem) {
        viewModel.clearDrawing() { ghostStrokes in
            DispatchQueue.main.async {
                self.drawingView.drawingStrokes = ghostStrokes
                self.drawingView.setNeedsDisplay()
            }
        }
    }
}

extension DrawingViewController: DrawingViewDelegate {
    func didEndDrawing(_ drawingStroke: DrawingStroke) {
        viewModel.handleDrawing(drawingStroke)

        viewModel.getGhostStrokes(for: drawingStroke.color, withDelay: drawingStroke.color.ghostDrawingDelay) { ghostStrokes in
            DispatchQueue.main.async {
                self.drawingView.drawingStrokes = ghostStrokes
                self.drawingView.setNeedsDisplay()
            }
        }
    }
}
