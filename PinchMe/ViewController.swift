//  ViewController.swift
//  PinchMe
//
//  Created by Daniel Catlett on 5/10/17.
//  Copyright © 2017 Daniel Catlett. All rights reserved.

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate
{
    private var imageView:UIImageView!
    private var scale = CGFloat(1)
    private var previousScale = CGFloat(1)
    private var rotation = CGFloat(0)
    private var previousRotation = CGFloat(0)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let image = UIImage(named: "yosemite-meadows")
        imageView = UIImageView(image: image)
        imageView.isUserInteractionEnabled = true
        imageView.center = view.center
        view.addSubview(imageView)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:)))
        pinchGesture.delegate = self
        imageView.addGestureRecognizer(pinchGesture)
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(ViewController.doRotate(_:)))
        rotationGesture.delegate = self
        imageView.addGestureRecognizer(rotationGesture)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithotherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return true
    }
    
    func transformImageView()
    {
        var t = CGAffineTransform(scaleX: scale * previousScale, y: scale * previousScale)
        t = t.rotate(rotation + previousRotation)
        imageView.transform = t
    }
    
    func doPinch(_ gesture:UIPinchGestureRecognizer)
    {
        scale = gesture.scale
        transformImageView()
        if(gesture.state == .ended)
        {
            previousScale = scale * previousScale
            scale = 1
        }
    }
    
    func doRotate(_ gesture:UIRotationGestureRecognizer)
    {
        rotation = gesture.rotation
        transformImageView()
        if(gesture.state == .ended)
        {
            previousRotation = rotation + previousRotation
            rotation = 0
        }
    }
}
