//
//  ViewController.swift
//  ApiBookDecoder
//
//  Created by Mac on 16/05/23.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var bookTabelVIew: UITableView!
    var books : [Book] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.bookTabelVIew.dataSource
       //self.bookTabelVIew.delegate
        bookTabelVIew.delegate = self
        bookTabelVIew.dataSource = self
        
        registerWithXIB()
        ApiFetching()
        // Do any additional setup after loading the view.
    }
    func registerWithXIB(){
        let uiNib = UINib(nibName: "BookTableViewCell", bundle: nil)
        self.bookTabelVIew.register(uiNib, forCellReuseIdentifier: "BookTableViewCell")
    }
    func ApiFetching(){
        guard let url = URL(string:"https://api.itbook.store/1.0/new")else {
                return
        }
        URLSession.shared.dataTask(with: url){
            data,error,response in
            guard let okData = data else{
                return
            }
            do {
                let apiResponse = try JSONDecoder().decode(BookResponse.self, from: okData)
                self.books = apiResponse.books
                print(self.books.count)
                //print(self.title?.count)
               // print("title")
            }
            catch{
                print("errorOccurred")
            }
            DispatchQueue.main.async {
              self.bookTabelVIew.reloadData()
            }
        }.resume()
    }
}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let bookTabelViewCell = bookTabelVIew.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell else{
            return(UITableViewCell())}
        bookTabelViewCell.titleLabel.text = books[indexPath.row].title
        bookTabelViewCell.subTitleLabel.text = books[indexPath.row].subtitle
        bookTabelViewCell.priceLabel.text = books[indexPath.row].price
        bookTabelViewCell.isbn13Label.text = books[indexPath.row].isbn13
       var imageString = URL(string:books[indexPath.row].image)
        bookTabelViewCell.bookImage.kf.setImage(with: imageString)
                return bookTabelViewCell
    }
    
    
}
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200.0
    }
    
}

