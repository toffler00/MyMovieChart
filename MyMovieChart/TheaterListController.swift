//
//  TheaterListController.swift
//  MyMovieChart
//
//  Created by ilhan won on 2018. 7. 2..
//  Copyright © 2018년 ilhan won. All rights reserved.
//

import UIKit

class TheaterListController: UITableViewController {

    // API를 통해 불러온 데이터를 저장할 배열 변수
    var list = [NSDictionary]()
    
    // 읽어올 데이터의 시작위치
    var startPoint = 0
    
    @IBOutlet weak var more: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // API를 호출한다.
       callTeaterAPI()
       
    }

    func callTeaterAPI() {
        // URL을 구성하기위한 상수 선언
        let requestURI = "http://swiftapi.rubypaper.co.kr:2029/theater/list"
        let sList = 100 // 불러올 데이터 갯수
        let type = "json" // 데이터 형식
        
        // 인자값들을 모아 URL 객체로 정의한다.
        let urlObj = URL(string: "\(requestURI)?s_page=\(self.startPoint)&s_list=\(sList)&type=\(type)")
        
        do {
            // NSString 객체를 이용하여 API를 호출하고 그 결과값을 인코딩된 문자열로 받아온다.
            let stringdata = try NSString(contentsOf: urlObj!, encoding: 0x80_000_422)
            
            // 문자열로 받은 데이터를 UTF-8 로 인코딩 처리한 Data 로 변환
            let encdata = stringdata.data(using: String.Encoding.utf8.rawValue)
       
            // Data 객체를 파싱하여 NSArray 객체로 변환한다.
            let apiArray = try JSONSerialization.jsonObject(with: encdata!, options: []) as? NSArray
            
            // 읽어온 데이터를 순회하면서 self.list 배열에 추가한다.
            for obj in apiArray! {
                self.list.append(obj as! NSDictionary)
            }
        } catch {
            // 경고창 형식으로 오류 메시지를 표시해준다.
            let alert = UIAlertController(title: "실패", message: "데이터 분석이 실패하였습니다.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            self.present(alert, animated: false, completion: nil)
        }
        // 읽어와야할 다음 페이지의 데이터 시작위치를 조정
        self.startPoint += sList
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segue_map") {
            // 실행된 세그의 식별자가 segue_map 일경우
            let path = self.tableView.indexPath(for: sender as! UITableViewCell)
            
            let data = self.list[path!.row]
            
            //세그웨이가 이동할 목적지 뷰 컨트롤러 객체를 구하고, 선언된 param 변수에 데이터를 연결해준다.
            (segue.destination as? TheaterViewController)?.param = data
        }
    }
    
    @IBAction func more(_ sender: Any) {
        callTeaterAPI()
        self.tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.list.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // self.list 배열에서 행에 맞는데이터를 꺼냄
        let obj = self.list[indexPath.row]
        
        //재사용 큐로부터 tCell 식별자에 맞는 셀 객체를 전달받음
        let cell = tableView.dequeueReusableCell(withIdentifier: "tCell") as! TheaterCell
        
        cell.name?.text = obj["상영관명"] as? String
        cell.tell?.text = obj["연락처"] as? String
        cell.addr?.text = obj["소재지도로명주소"] as? String

        // Configure the cell...

        return cell
    }
    
}
