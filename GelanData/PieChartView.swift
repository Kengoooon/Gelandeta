//
//  PieChartView.swift
//  GelanData
//
//  Created by 藤本健悟 on 2017/02/26.
//  Copyright © 2017年 kengo. All rights reserved.
//

import Foundation
import UIKit

struct Segment {
    
    // MARK: セグメントの背景色
    var color : UIColor
    
    // MARK: セグメントの割合を設定する変数（比率）
    var value : CGFloat
}

class PieChartView: UIView {
    var segments = [Segment]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        //CGContextの初期化
        let ctx = UIGraphicsGetCurrentContext()
        //円型にするためにradiusを設定
        let radius = min(frame.size.width, frame.size.height)/2
        //Viewの中心点を取得
        let viewCenter = CGPoint(x: bounds.size.width/2, y: bounds.size.height/2)
        //セグメントごとの比率に応じてグラフを変形するための定数
        let valueCount = segments.reduce(0) {$0 + $1.value}
        //円グラフの起点を設定
        var startAngle = -CGFloat(M_PI*0.5)
        //初期化されたすべてのセグメントを描画するための処理
        for segment in segments { // loop through the values array
            ctx?.setFillColor(segment.color.cgColor)
            let endAngle = startAngle+CGFloat(M_PI*2)*(segment.value/valueCount)
            ctx?.move(to: CGPoint(x:viewCenter.x, y: viewCenter.y))
            ctx?.addArc(center: CGPoint(x:viewCenter.x, y: viewCenter.y), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            ctx?.fillPath()
            startAngle = endAngle
        }
    }
}
