//
//  TutorialViewController.swift
//  Carousel
//
//  Created by Andrew Lyons on 22 Oct 14.
//  Copyright (c) 2014 Andrew Lyons. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, UIScrollViewDelegate
{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var takeSpinView: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = imageView1.frame.size
        scrollView.contentSize.width = imageView1.frame.width * 4
        scrollView.delegate = self
        takeSpinView.alpha = 0
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        var page = Int(scrollView.contentOffset.x / 320)
        pageControl.currentPage = page
        if page == 3
        {
            UIView.animateWithDuration(0.1, animations:
            {
                self.takeSpinView.alpha = 1
            })
        } else
        {
            UIView.animateWithDuration(0.1, animations:
                {
                    self.takeSpinView.alpha = 0
            })
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
