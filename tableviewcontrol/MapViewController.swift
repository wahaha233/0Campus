//
//  MapViewController.swift
//  tableviewcontrol
//
//  Created by GeorgeMao on 2017/3/27.
//  Copyright © 2017年 GeorgeMao. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {
    var area: AreaMO!

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsUserLocation = true
        mapView.showsTraffic = true
        
        
        let coder = CLGeocoder()
        coder.geocodeAddressString(area.name!) { (ps, error) in
            guard let ps = ps else{
                print(error ?? "未知错误")
                return
            }
            
            let place = ps.first
            
            let annotation = MKPointAnnotation()
            annotation.title = self.area.name
            annotation.subtitle = self.area.province
            
            
            if let loc = place?.location{
                annotation.coordinate = loc.coordinate
                self.mapView.showAnnotations([annotation], animated: true)
                self.mapView.selectAnnotation(annotation, animated: true)
            }
            
        }
        // Do any additional setup after loading the view.
    }
    

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
            let id = "myid"
            var av = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKPinAnnotationView
            
            if av == nil {
                av = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
                av?.canShowCallout = true
            }
            
            let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
            leftIconView.image = UIImage(data: area.areasimage as! Data)
            av?.leftCalloutAccessoryView = leftIconView
        
            return av
        }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
