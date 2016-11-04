//
//  BlurViewController.swift
//  Insta360Nano
//
//  Created by 黄明 on 2016/11/3.
//  Copyright © 2016年 Insta360. All rights reserved.
//

import UIKit

open class BlurViewController: UIViewController {
    public var blurStyle: UIBlurEffectStyle {
        get {
            return presenter.blurStyle
        }
        set {
            presenter.blurStyle = newValue
        }
    }
    
    fileprivate let presenter = BlurPresenter()
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    func setup() {
        modalPresentationStyle = .custom
        transitioningDelegate = presenter
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.clear
    }
}
