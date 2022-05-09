//
//  SlideMenuView.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/17.
//

import UIKit

class SlideMenuView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    weak var delegate : SlideMenuVIewProtocol? = nil
    override init(frame: CGRect) { // by code
        super.init(frame: frame)
//        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.backgroundColor = .white
        
        let swipeLEft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLEft.direction = .left
        self.addGestureRecognizer(swipeLEft)
        
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                print("Swiped down")
            case .left:
                print("Swiped left")
                self.delegate?.swipeLeft()
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
    }
}

protocol SlideMenuVIewProtocol : NSObjectProtocol{
    func swipeLeft()

}
