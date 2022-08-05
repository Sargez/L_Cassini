//
//  ImageViewController.swift
//  Cassini
//
//  Created by 1C on 01/06/2022.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if imageURL == nil {
//            imageURL = DemoURLs.stanford
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if image == nil {
            fetchImage()
        }
//        var usualString = ""
//        
//        func task(_ symbol: String) {
//            for i in 1...10 {
//                print("\(symbol) \(i) prioritet: \(qos_class_self().rawValue)")
//                usualString = usualString + symbol
//            }
//        }
//        
//        let workQueue1 = DispatchQueue(label: "Zlo1", qos: .userInitiated, attributes: .concurrent)
//        let workQueue2 = DispatchQueue(label: "Zlo2", qos: .userInitiated, attributes: .concurrent)
//        
//        workQueue2.async {
//            task("🌚")
//        }
//        workQueue1.async {
//            task("🌝")
//        }
        
    }
    
    var imageView = UIImageView()
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
//            scrollView.contentInsetAdjustmentBehavior = .never
//            scrollView.bounces = false
//            scrollView.isDirectionalLockEnabled = false
//            scrollView.scrollsToTop=false
//            scrollView.isScrollEnabled = false
//            scrollView.isPagingEnabled = false
            scrollView.indicatorStyle = .white
            scrollView.flashScrollIndicators()
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set (imageToSet) {
            imageView.image = imageToSet
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
    private func fetchImage() {
            
        if let url = imageURL {
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents , self?.imageURL == url {
                        print("in")
                        self?.image = UIImage(data: imageData)
//                        self?.scrollView.flashScrollIndicators()
//                        self?.scrollView.scrollRectToVisible(CGRect(origin: CGPoint(x: 50, y: 50), size: self!.imageView.frame.size), animated: true)
//                        self?.scrollView.zoomScale = 1/10
                        print("out")
                        print("\(qos_class_self().rawValue)")
                    }
                }
                print("test")
            }
        }
    }
    
//    private func fetchImageCopy() {
//        if let url = imageURL {
//            let urlContents = try? Data(contentsOf: url)
//            if let imageData = urlContents {
//                imageView.image = UIImage(data: imageData)
//            }
//        }
//    }
}
