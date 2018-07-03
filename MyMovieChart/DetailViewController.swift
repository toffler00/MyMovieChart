//
//  DetailViewController.swift
//  MyMovieChart
//
//  Created by ilhan won on 2018. 6. 27..
//  Copyright © 2018년 ilhan won. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController{
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var wv: WKWebView!
    var mvo : MovieVO!
    override func viewDidLoad() {
        super.viewDidLoad()
        // WKNavigationDelegate의 델리게이트 객체를 지정
        self.wv.navigationDelegate = self
        
        NSLog("linkurl = \(self.mvo.detail!), title = \(self.mvo.title!)")
        
        let navibar = self.navigationItem
        navibar.title = self.mvo.title
        
        // URLRequest 인스턴스를 생성한다.
        let url = URL(string: self.mvo.detail!)
        let req = URLRequest(url: url!)
        
        self.wv.load(req)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - WKNavigationDelegate 프로토콜 구현
extension DetailViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        // 인디케이터 뷰의 애니메이션을 실행
        self.spinner.startAnimating()
        spinner.hidesWhenStopped = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // 웹뷰의 오류발생시 인디케이터 뷰의 애니메이션 중지
        self.spinner.stopAnimating()
        self.alert("상세페이지를 읽어오지 못하였습니다.") {
            // 버튼 클릭시, 이전화면으로 되돌려 보낸다.
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.spinner.stopAnimating()
    }
    
}

extension UIViewController {
    func alert(_ message : String, onClick : (() -> Void)? = nil) {
        let controller = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
            onClick?()
        }))
        DispatchQueue.main.async {
            self.present(controller, animated: false, completion: nil)
        }
    }
}
