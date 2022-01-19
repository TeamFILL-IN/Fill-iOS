//
//  FilmSelectViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/19.
//

import UIKit

class FilmSelectViewController: UIViewController {
    
    // MARK: - Properties
    var viewWidth = UIScreen.main.bounds.width
    var selectedTag = 0
    var selectedLeading: CGFloat = 0
    var selectedFilm = ""
    var serverFilmList: FilmResponse?
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var navigationBar: FilinNavigationBar!
    @IBOutlet var filmTypeButtons: [UIButton]!
    @IBOutlet weak var chosenViewLeading: NSLayoutConstraint!
    @IBOutlet weak var filmTypeTableView: UITableView!
    
    // MARK: - @IBAction Properties
    @IBAction func touchFilmTypeButtons(_ sender: UIButton) {
        if !sender.isSelected {
            filmTypeButtons.forEach {
                $0.isSelected = false
            }
            selectedTag = sender.tag
            selectedLeading = (viewWidth/4) * CGFloat(sender.tag)
            chosenViewLeading.constant = selectedLeading
            
            setSelectedFilm()
            listOfFilmsWithAPI(styleId: selectedTag + 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setNavigationBar()
        registerXib()
        setSelectedFilm()
        listOfFilmsWithAPI(styleId: selectedTag + 1)
    }
}
// MARK: - Extensions
extension FilmSelectViewController {
    private func setUI() {
        filmTypeButtons.forEach {
            $0.titleLabel?.font = .subhead2
        }
        if #available(iOS 15, *) {
            filmTypeTableView.sectionHeaderTopPadding = 0
        }
        filmTypeTableView.delegate = self
        filmTypeTableView.dataSource = self
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        navigationBar.popViewController = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func registerXib() {
        filmTypeTableView.register(FilmTypeTableViewCell.nib(), forCellReuseIdentifier: Const.Xib.filmTypeTableViewCell)
    }
    
    private func setSelectedFilm() {
        filmTypeButtons[selectedTag].isSelected = true
        chosenViewLeading.constant = selectedLeading
    }
}

// MARK: - UITableViewDataSource
extension FilmSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let filmCell = tableView.dequeueReusableCell(withIdentifier: Const.Xib.filmTypeTableViewCell, for: indexPath) as? FilmTypeTableViewCell else {
            return UITableViewCell()
        }
        
        filmCell.filmNameLabel.text = serverFilmList?.films[indexPath.row].name
        return filmCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

// MARK: - UITableViewDelegate
extension FilmSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filmCell = tableView.cellForRow(at: indexPath) as? FilmTypeTableViewCell
        filmCell?.isSelected = true
        selectedFilm = filmCell?.filmNameLabel.text ?? ""
        let selectedFilmDict = ["selectedTag": selectedTag,
                                "selectedLeading": selectedLeading,
                                "selectedFilm": selectedFilm] as [String: Any]
        NotificationCenter.default.post(name: NSNotification.Name.updateSelectedFilmType, object: selectedFilmDict, userInfo: nil)
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Network
extension FilmSelectViewController {
    func listOfFilmsWithAPI(styleId: Int) {
        FlimSelectAPI.shared.listOfFilms(styleId: styleId) { response in
            switch response {
            case .success(let data):
                if let films = data as? FilmResponse {
                    self.serverFilmList = films
                    self.filmTypeTableView.reloadData()
                }
            case .requestErr(let message):
                print("listOfFilmsWithAPI - requestErr: \(message)")
            case .pathErr:
                print("listOfFilmsWithAPI - pathErr")
            case .serverErr:
                print("listOfFilmsWithAPI - serverErr")
            case .networkFail:
                print("listOfFilmsWithAPI - networkFail")
            }
        }
    }
}
