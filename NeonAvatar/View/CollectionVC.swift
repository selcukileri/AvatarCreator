//
//  HomeViewController.swift
//  NeonAvatar
//
//  Created by Selçuk İleri on 3.04.2024.
//

import UIKit
import CoreData
import NeonSDK
import RxSwift
import RxCocoa

class CollectionVC: UIViewController, UICollectionViewDelegate {
    
    private var viewModel = CollectionVM()
    private var disposeBag = DisposeBag()
    
    enum Section {
        case main
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Avatarss>!
    var avatarList2 = [Avatarss]()
    let addButton = UIButton()
    
    let deleteButton = UIButton()
    var prompt = "default prompt"
    var size = "defaults size"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: 0x0C0C0C)

        configureCollectionView()
        //configureNeonCollectionView()
        viewModel.avatarListObservable
            .subscribe(onNext: { [weak self] avatarList in
                self?.avatarList2 = avatarList
                self?.updateData()
            })
            .disposed(by: disposeBag)
        fetchAvatarList()
        //configureDataSource()

        
        
    }
    
    func configureNeonCollectionView(){
        
        addButton.setImage(UIImage(systemName: "plus.app"), for: .normal)
        addButton.addTarget(self, action: #selector(addClicked), for: .touchUpInside)
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.height.equalTo(50)
            make.trailing.equalToSuperview().offset(10)
            make.width.equalTo(100)
        }
        
        
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.backgroundColor = UIColor(hex: 0x2A2A2A)
        deleteButton.addTarget(self, action: #selector(deleteClicked), for: .touchUpInside)
        view.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(100)
        }
        print("neon collectionView")
        let collectionView = NeonCollectionView<Avatarss, NeonAvatarCell>(
            objects: avatarList2,
            itemsPerRow: 2,
            leftPadding: 20,
            rightPadding: 20,
            horizontalItemSpacing: 30,
            verticalItemSpacing: 20
        )
        collectionView.backgroundColor = UIColor(hex: 0x0C0C0C)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(addButton.snp.bottom).offset(10)
        }
        
        collectionView.didSelect = { object, indexPath in
        }
        
        collectionView.contextMenuActions = [
            ContextMenuAction<Avatarss>(title: "Delete", imageSystemName : "trash", isDestructive: true) { [self] avatarss, indexPath in
                // Delete operations
                //guard let self = self else { return }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: { [self] in
//                        avatarss.remove(at: indexPath.row)
//                        collectionView.objects = avatarss
//                })
                
            },
            ContextMenuAction<Avatarss>(title: "Edit") { avatarss, indexPath in
                //print("Edit action for \(avatarss.)")
            }
        ]
    
    }
    
    func fetchAvatarList(){
        viewModel.fetchAvatarList()
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Avatarss>(collectionView: collectionView, cellProvider: { collectionView, indexPath, avatar in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarCell.reuseID, for: indexPath) as! AvatarCell
            cell.set(avatar: avatar)
            return cell
        })
        
    }
    
    func configureCollectionView(){

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumnFlowLayout())
        collectionView.backgroundColor = UIColor(hex: 0x0C0C0C)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(AvatarCell.self, forCellWithReuseIdentifier: AvatarCell.reuseID)
        
        addButton.setImage(UIImage(systemName: "plus.app"), for: .normal)
        addButton.addTarget(self, action: #selector(addClicked), for: .touchUpInside)
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.height.equalTo(50)
            make.trailing.equalToSuperview().offset(10)
            make.width.equalTo(100)
        }
        
        
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.backgroundColor = UIColor(hex: 0x2A2A2A)
        deleteButton.addTarget(self, action: #selector(deleteClicked), for: .touchUpInside)
        view.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(100)
        }
        configureDataSource()
    }
    
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Avatarss>()
        snapshot.appendSections([.main])
        snapshot.appendItems(avatarList2)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot,animatingDifferences: true)
        }
    }
    
    @objc func addClicked(){
        let homeVC = HomeVC()
        present(destinationVC: homeVC, slideDirection: .down)
    }
    
    @objc func deleteClicked(){
        viewModel.deleteAllAvatars { [weak self] success in
            guard let self = self else {
                return
            }
            if success {
                self.fetchAvatarList()
            } else {
                print("failed to delete items")
            }
        }
    }
    

    
}
