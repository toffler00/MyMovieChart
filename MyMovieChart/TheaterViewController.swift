//
//  TheaterViewController.swift
//  MyMovieChart
//
//  Created by ilhan won on 2018. 7. 3..
//  Copyright © 2018년 ilhan won. All rights reserved.
//

import UIKit
import MapKit

class TheaterViewController: UIViewController {
    
    // 전달되는 데이터를 받을 변수
    var param : NSDictionary!
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.param["상영관명"] as? String
        
        // 1. 위도와 경도를 추출하여 Double 값으로 캐스팅
        let lat = (param?["위도"] as! NSString).doubleValue
        let lng = (param?["경도"] as! NSString).doubleValue
        
        // 2. 위도와 경도를 인수로하는 2D 위치 정보 객체정의
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        // 3. 지도에 표현될 거리 : 값의 단위는 m
        let regionRadius : CLLocationDistance = 100
        
        // 4. 거리를 반영한 지역 정보를 조합한 지도 데이터 생성
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius, regionRadius)
        // 5. map 변수에 연결된 지도 객체에 데이터를 전달하여 화면에 표시
        self.map.setRegion(coordinateRegion, animated: true)
        
        // 6. 위치를 표시할 객체정의하고 표시
        let point = MKPointAnnotation()
        point.coordinate = location
        
        self.map.addAnnotation(point)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
