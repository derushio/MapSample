//
//  ViewController.swift
//  MapSample
//
//  Created by 中塩成海 on 2015/06/23.
//  Copyright (c) 2015年 Derushio. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    var isSetUped = false

    var displaySize: CGSize?

    var mapView: MKMapView?
    var onLongClickListener: UILongPressGestureRecognizer = UILongPressGestureRecognizer()
    // ロングクリックのリスナ

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidLayoutSubviews() {
        // AutoLayoutで配置されたViewのサイズが確定した後一番早く呼ばれるメソッド
        // 今回は別にviewDidLoadでも良い
        if (!isSetUped) {
            displaySize = UIScreen.mainScreen().bounds.size

            mapView = MKMapView(frame: CGRectMake(0, 0, displaySize!.width, displaySize!.height))
            onLongClickListener.addTarget(self, action: "onMapLongClick:")
            mapView!.addGestureRecognizer(onLongClickListener)
            self.view.addSubview(mapView!)

            isSetUped = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onMapLongClick(sender: UILongPressGestureRecognizer) {
        //指を離したときだけ反応するようにする
        if(sender.state != .Began){
            return
        }
        
        var location = sender.locationInView(self.mapView)
        // こいつがタッチされたロケーション
        var mapPoint:CLLocationCoordinate2D = mapView!.convertPoint(location, toCoordinateFromView: self.mapView)
        
        // ここから
        var theRoppongiAnnotation = MKPointAnnotation()
        theRoppongiAnnotation.coordinate  = mapPoint
        theRoppongiAnnotation.title       = "Point"
        theRoppongiAnnotation.subtitle    = "Message"
        mapView!.addAnnotation(theRoppongiAnnotation)
        
        // ズーム機能
        var span: MKCoordinateSpan = MKCoordinateSpanMake(1, 1);
        var region: MKCoordinateRegion = MKCoordinateRegion(center: mapPoint, span: MKCoordinateSpanMake(1, 1))
        mapView!.setRegion(region, animated: true)
        // ズーム機能
        
        // ここまでピンを立てるサンプル
    }
}
