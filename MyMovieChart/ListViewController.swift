//
//  ListViewController.swift
//  MyMovieChart
//
//  Created by ilhan won on 2018. 6. 13..
//  Copyright © 2018년 ilhan won. All rights reserved.
//

import UIKit

class ListViewController : UITableViewController {
    
    // 테이블 뷰를 구성할 리스트 데이터
    lazy var list : [MovieVO] = {
        var datalist = [MovieVO]()
        return datalist
    }()
    
    // 현재까지 읽어온 데이터의 페이지 정보
    var page = 1
    
    @IBOutlet weak var moreBtn: UIButton!
    
    override func viewDidLoad() {
        callMovieAPI()
    }
    
    @IBAction func more(_ sender: Any) {
        self.page += 1
        callMovieAPI()
        self.tableView.reloadData()
    }
    
    func callMovieAPI() {
        // 호핀 API 호출을 위한 URI를 생성
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=\(self.page)&count=30&genreId=&order=releasedateasc"
        let apiURI : URL! = URL(string: url)
        
        // REST API를 호출
        let apidata = try! Data(contentsOf: apiURI)
        
        // 데이터전송 결과를 로그로 출력(해도되고 안해도되고)
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
        NSLog("API Result \(log)")
        
        // JSON 객체를 파싱하여 NSDictionary 객체로 받음
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            // 데이터 구조에 따라 차례대로 캐스팅하며 읽어온다.
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            // Iterator 처리를 하면서 API 데이터를 MovieVO 객체에 저장한다.
            for row in movie {
                // 순회상수를 NSDictionary 타입으로 캐스팅
                let r = row as! NSDictionary
                
                // 테이블 뷰 리스트를 구성할 데이터 형식
                let mvo = MovieVO()
                
                // moview 배열의 각 데이터를 mvo 상수의 속성에 대입
                mvo.title = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail = r["thumbnailImage"] as? String
                mvo.detail = r["linkUrl"] as? String
                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
                
                let url : URL! = URL(string: mvo.thumbnail!)
                let imageData = try! Data(contentsOf: url)
                mvo.thumbnailImage = UIImage(data: imageData)
                // list 배열에 추가
                self.list.append(mvo)
                
                let totalCount = (hoppin["totalCount"] as? NSString)!.integerValue
                
                if (self.list.count >= totalCount) {
                    self.moreBtn.isHidden = true
                }
            }
        } catch {
            NSLog("Parse Error")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        print(list.count)
        
        cell.title.text = row.title
        cell.desc.text = row.description
        cell.opendate.text = row.opendate
        cell.rating.text = "\(row.rating!)"
        cell.thumbnail.image = row.thumbnailImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 항은 \(indexPath.row) 번째 행입니다.")
    }
}
