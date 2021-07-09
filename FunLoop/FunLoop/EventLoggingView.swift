//
//  EventLoggingView.swift
//  FunLoop
//
//  Created by Mikey Ward on 7/8/21.
//

import UIKit

class EventLoggingView: UIView {
    
    var inputs = 0 {
        didSet {
            inputsLabel.text = "Inputs: \(inputs)"
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        spawnTimer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        spawnTimer()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        print("\(Date()) [DRAW]")
    }
    
    lazy var inputsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
        return label
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleInput(#function)
        spawnWorkOnMain()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleInput(#function)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleInput(#function)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleInput(#function)
    }
    
    func handleInput(_ function: String) {
        print("\(Date()) [INPUT] \(function)")
        inputs += 1
    }
    
    func spawnWorkOnMain() {
        for i in 1...10 {
            print("\(Date()) [WORK] Enqueued Worker #\(i)")
            DispatchQueue.main.async {
                self.doMath()
                self.setNeedsDisplay()
                print("\(Date()) [WORK] Finished Worker #\(i)")
            }
        }
    }
    
    func spawnTimer() {
        print("\(Date()) [TIMER] starting")
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {
            _ in
            print("\(Date()) [TIMER] tick")
            self.setNeedsDisplay()
        })
    }
    
    func doMath() {
        var n = 0.0
        for _ in 1..<1000000 {
            n = sin(sin(sin(sin(sin(sin(sin(Double.random(in: 0...1))))))))
        }
    }
}
