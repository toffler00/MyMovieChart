//
//  File.swift
//  MyMovieChart
//
//  Created by ilhan won on 2018. 6. 13..
//  Copyright © 2018년 ilhan won. All rights reserved.
//

import Foundation
import UIKit

class MovieVO {
    var thumbnail : String? // 영화 섬네일 이미지 주소
    var title : String? // 영화 제목
    var description : String? // 영화 설명
    var detail : String? // 상세정보
    var opendate : String? // 개봉일
    var rating : Double? // 평점
    
    // 영화 썸네일 이미지를 담을 UIImage 객체
    var thumbnailImage : UIImage?
}
