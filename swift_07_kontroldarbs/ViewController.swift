//
//  ViewController.swift
//  swift_07_kontroldarbs
//
//  Created by Paulis Zabarovskis on 17/06/2022.
//
import Foundation
import UIKit
import WebKit

enum ControllerMode: Int {
    case sampleHTML
    case url1
    case url2
    case error
}
let errorString = "<Html> <Body> <p> <!-- It is an ERROR message for every case --> <h1> ERROR </h1> <h2>something goes wrong </h2> <i> <u> This app is useless!!! </u> </p>  </i> Contact Your stupid developer to fix bugs in this app! </p> </Body> </Html>"

class ViewController: UIViewController {
    // UZDEVUMS: WKWEB elements tīmekļa satura attēlošanai
    //MARK:-Outlets
    @IBOutlet weak var webView: WKWebView!
    
    var controllerMode: ControllerMode = .sampleHTML
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    func loadData() {
        switch controllerMode {
 // UZDEVUMS: vienam segmentam piesaistīt resursos ievietotā html faila saturu
        case .sampleHTML:
            if let htmlFile = Bundle.main.path(forResource: "html_sample", ofType: "html") {
                var htmlString: String?
                do {
                    htmlString = try String(contentsOfFile: htmlFile)
                }
                catch {
                    // can't read file
                    htmlString = errorString
                }
                if let html = htmlString {
                    // Load to View
                    self.webView?.loadHTMLString(html, baseURL: nil)
                } else {
                    // couldn't get file content
                    self.webView?.loadHTMLString(errorString, baseURL: nil)
                }
            } else {
                //file not found
                self.webView?.loadHTMLString(errorString, baseURL: nil)
            }
            // UZDEVUMS: pārējos divos – tīmekļa lappuses ielādēt pēc iepriekš definētiem URL
        case .url1:
            let url1String = "https://pgm.lv"
            if let url = URL(string: url1String) {
                //Create request
                let request = URLRequest(url: url)
                // Load to View
                self.webView?.load(request)
            } else {
                //wrong URL string syntax
                self.webView?.loadHTMLString(errorString, baseURL: nil)
            }
            
        case .url2:
            let url1String = "https://turiba.lv"
            if let url = URL(string: url1String) {
                //Create request
                let request = URLRequest(url: url)
                self.webView?.load(request)
            } else {
                //wrong URL string syntax
                self.webView?.loadHTMLString(errorString, baseURL: nil)
           }
        case .error:
            self.webView?.loadHTMLString(errorString, baseURL: nil)
        }
    }
    // UZDEVUMS: UISegmentedControl elements ar trijām izvēlēm
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            controllerMode = .sampleHTML
        case 1:
            controllerMode = .url1
        case 2:
            controllerMode = .url2
        default:
            controllerMode = .error
        }
        self.loadData()
   }
}

