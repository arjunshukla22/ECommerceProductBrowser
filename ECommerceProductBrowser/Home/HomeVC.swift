//
//  HomeVC.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 24/05/25.
//

import UIKit
import Combine

class HomeVC: UIViewController {
    
    @IBOutlet weak var collCategory: UICollectionView!
    @IBOutlet weak var collProducts: UICollectionView!
    
    
    private let viewModel = HomeViewModel(homeService: HomeService())
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        setupCollVw()
        
        bindViewModel()
    }
    
    
    private func setUpUI(){
        
        // Hide Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let retrievedUser : UserProfileResponse? = UserDefaultsManager.shared.loadUser()
        debugPrint(/retrievedUser?.name)
        
    }
    
    private func bindViewModel() {
        viewModel.$categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] categories in
                // reload your category collection/table view
               // print("Categories updated:", categories)
                
                self?.collCategory.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$products
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
                // reload your product collection/table view
                //print("Products updated:", products)
                
                self?.collProducts.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                // Show an alert or label
                print("Error: \(error)")
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                // show/hide loader
                print("Loading:", isLoading)
            }
            .store(in: &cancellables)
    }
    
    
}



// MARK: Collection view Delegate & Data Source
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case collCategory:
            return CGSize(width: 80, height: 80)
        case collProducts:
            return CGSize(width: collectionView.frame.size.width/2, height: 240)
        default:
            return CGSizeZero
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collCategory:
            return self.viewModel.categories.count
        case collProducts:
            return self.viewModel.products.count
        default:return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch collectionView {
        case collCategory:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVC", for: indexPath) as? CategoryCVC else { return UICollectionViewCell() }
            
            let category = viewModel.categories[indexPath.item]
            cell.bindCellData(category: category)
            
            return cell
        case collProducts:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCVC", for: indexPath) as? ProductCVC else { return UICollectionViewCell() }
            let product = viewModel.products[indexPath.item]
            cell.bindCellData(product: product)
            
            return cell
        default:return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        switch collectionView {
        case collCategory:
            let selected = viewModel.categories[indexPath.item]
            viewModel.selectedCategoryId = "\(selected.id)"
            
        case collProducts:break
        default:break
        }
        
    }
}


extension HomeVC {
    func setupCollVw(){
        
        self.collCategory.showsVerticalScrollIndicator = false
        self.collCategory.showsHorizontalScrollIndicator = false
        
        self.collCategory.register(UINib(nibName: "CategoryCVC", bundle: .main), forCellWithReuseIdentifier: "CategoryCVC")
        self.collCategory.collectionViewLayout.invalidateLayout()
        
        
        
        self.collProducts.showsVerticalScrollIndicator = false
        self.collProducts.showsHorizontalScrollIndicator = false
        
        self.collProducts.register(UINib(nibName: "ProductCVC", bundle: .main), forCellWithReuseIdentifier: "ProductCVC")
        // self.collProducts.collectionViewLayout.invalidateLayout()
        
    }
    
}
