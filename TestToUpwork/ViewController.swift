//
//  ViewController.swift
//  TestToUpwork
//
//  Created by Andrey Elpaev on 02/05/2017.
//  Copyright © 2017 ClearSofrware. All rights reserved.
//

import UIKit
import GoogleMaps
import GradientView

enum Type: Int {
    case cost
    case distance
}

protocol BarTapDelegate: class {
    func tap(_ type: Type)
}

class ViewController: UIViewController, SwipeDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var map: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var dragView: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var distanceButton: UIButton!
    @IBOutlet weak var costButton: UIButton!
    
    @IBOutlet weak var searchIcon: UIImageView!
    
    @IBOutlet weak var listConstraint: NSLayoutConstraint!
    @IBOutlet weak var arrowConstraint: NSLayoutConstraint!
    
    var mapController: GoogleMapViewController!
    
    weak var delegate: BarTapDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Fuel Buddy"

        let gear = UIImage(named: "gear")?.withRenderingMode(.alwaysOriginal)
        let right = UIBarButtonItem(image: gear, style: .plain, target: nil, action: nil)
        
        let user = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
        let left = UIBarButtonItem(image: user, style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItem = right
        navigationItem.leftBarButtonItem = left
        mapController = GoogleMapViewController()
        mapController.delegate = self
        
        configureUI()
        displayMap(mapController)
        configureTextFields()
        configureButtons()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let pageController = storyBoard.instantiateViewController(withIdentifier: "page") as! ListPageViewController
        pageController.mainController = self
        pageController.swipeDelegate = self
        
        pageController.googleMapController = mapController
        
        displayList(pageController)
        

    }

    
    func swipe(_ type: Type) {
        
        if type == .distance {
            distanceButton.setTitleColor(.white, for: .normal)
            costButton.setTitleColor(UIColor(hexString: "#7b7b7b"), for: .normal)
            arrowConstraint.constant = 0
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                
                self.view.layoutIfNeeded()
                
            }, completion: nil)
            return
        }
        
        if type == .cost {
            distanceButton.setTitleColor(UIColor(hexString: "#7b7b7b"), for: .normal)
            costButton.setTitleColor(.white, for: .normal)
            
            arrowConstraint.constant = distanceButton.bounds.width

            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                
                self.view.layoutIfNeeded()
                
            }, completion: nil)
            return
        }
        
        
        
    }
    
    func onSwipe(_ gesture: UISwipeGestureRecognizer) {
        
        switch gesture.state {

        case .ended:
            
            if gesture.direction == .down {
                
                listConstraint.constant = -100
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                    
                    self.view.layoutIfNeeded()
                    
                }, completion: nil)
                
                gesture.direction = .up
                return
            }
            
            if gesture.direction == .up {
                listConstraint.constant = -300
                
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                    
                    self.view.layoutIfNeeded()
                    
                }, completion: nil)
                
                gesture.direction = .down
                return
            }

        break
            
        default:
            break
        }

    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }

    
    fileprivate func configureUI() {
        
        let bar = navigationController?.navigationBar
        let frame = CGRect(x: 0, y: 0, width: (bar?.bounds.width)!, height: 120)
        let gradientView = GradientView(frame: frame)
        gradientView.backgroundColor = .clear
        gradientView.colors = ColorPalette.gradient
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleRightMargin]
        view.addSubview(gradientView)
        bar?.setBackgroundImage(UIImage(), for: .default)
        bar?.shadowImage = UIImage()
        bar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

    }
    
    @IBAction func tapToDistance(_ sender: UIButton) {
        
        costButton.setTitleColor(UIColor(hexString: "#7b7b7b"), for: .normal)
        distanceButton.setTitleColor(.white, for: .normal)
        arrowConstraint.constant = 0
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        delegate?.tap(.distance)
    }
    
    
    @IBAction func tapToCost(_ sender: UIButton) {
        costButton.setTitleColor(.white, for: .normal)
        distanceButton.setTitleColor(UIColor(hexString: "#7b7b7b"), for: .normal)
        arrowConstraint.constant = costButton.bounds.width
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        delegate?.tap(.cost)
    }
    
    fileprivate func configureTextFields() {
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor(hexString: "#a9a9a9").cgColor
        searchTextField.layer.cornerRadius = 4
        
        let attributed = NSAttributedString(string: "Поиск заправки", attributes: [ NSForegroundColorAttributeName: UIColor(hexString: "#cecece"), NSFontAttributeName: UIFont.italicSystemFont(ofSize: 14)])
        
        
        searchTextField.attributedPlaceholder = attributed
        searchTextField.leftViewMode = .always
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 31, height: 10))
        
        view.bringSubview(toFront: searchTextField)
        view.bringSubview(toFront: addButton)
        view.bringSubview(toFront: searchIcon)
        

    }
    
    fileprivate func configureButtons() {
        costButton.backgroundColor = UIColor(hexString: "#3a3a3a")
        distanceButton.backgroundColor = UIColor(hexString: "#3a3a3a")
        
        costButton.setTitleColor(UIColor(hexString: "#7b7b7b"), for: .normal)
        distanceButton.setTitleColor(.white, for: .normal)

        
        let layer = CAShapeLayer()
        layer.path = shadowPath()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = "round"
        layer.position = CGPoint(x: 0, y: -20)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.35
        layer.shadowRadius = 3.0
        layer.shouldRasterize = true
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowPath = shadowPath()
        
        
        view.bringSubview(toFront: dragView)
        containerView.layer.insertSublayer(layer, at: 0)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
        swipeGesture.direction = .down
        
        dragView.isUserInteractionEnabled = true
        dragView.addGestureRecognizer(swipeGesture)
        dragView.roundCorners(corners: [.topLeft, .topRight], radius: 5)
    }
    
    
    fileprivate func shadowPath() -> CGPath {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 15))
        path.addLine(to: CGPoint(x: 375, y: 15))
        path.addLine(to: CGPoint(x: 375, y: 59))
        path.addLine(to: CGPoint(x: 0, y: 59))
        path.addLine(to: CGPoint(x: 0, y: 15))
        path.close()
        
        path.move(to: CGPoint(x: 141.5, y: 0))
        path.addLine(to: CGPoint(x: 233.5, y: 0))
        path.addCurve(to: CGPoint(x: 237.5, y: 4), controlPoint1: CGPoint(x: 235.71, y: 0), controlPoint2: CGPoint(x: 237.5, y: 1.79))
        path.addLine(to: CGPoint(x: 237.5, y: 15))
        path.addLine(to: CGPoint(x: 137.5, y: 15))
        path.addLine(to: CGPoint(x: 137.5, y: 4))
        path.addCurve(to: CGPoint(x: 141.5, y: 0), controlPoint1: CGPoint(x: 137.5, y: 1.79), controlPoint2: CGPoint(x: 139.29, y: 0))
        path.close()
        
        return path.cgPath
    }

    
    fileprivate func displayMap(_ content: UIViewController) {
        addChildViewController(content)
        content.view.frame = map.bounds
        map.addSubview(content.view)
        content.didMove(toParentViewController: self)
        
        mapController.renderMarkers()
    }
    
    fileprivate func displayList(_ content: UIViewController) {
        addChildViewController(content)
        content.view.frame = listView.bounds
        listView.addSubview(content.view)
        content.didMove(toParentViewController: self)
    }

}

extension ViewController: GMSMapDelegate {
    func didTap() {
        view.endEditing(true)
    }
}

