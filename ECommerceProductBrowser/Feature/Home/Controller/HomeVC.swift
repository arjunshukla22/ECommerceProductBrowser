//
//  HomeVC.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 24/05/25.
//

import UIKit
import Combine
import TTGSnackbar

class HomeVC: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var vWUser: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var emptyStateView: UIView!
    
    @IBOutlet weak var collCategory: UICollectionView!
    @IBOutlet weak var collProducts: UICollectionView!
    
    @IBOutlet weak var mainShimmerVw : UIView!
    @IBOutlet weak var innerShimmVw : UIView!
    
    
    @IBOutlet weak var vWMainSearch: UIView!
    @IBOutlet weak var btnSearchOL: UIButton!
    @IBOutlet weak var vWSearch: UIView!
    @IBOutlet weak var txtFldSearch: UITextField!
    @IBOutlet weak var btnSearchCancel: UIButton!
    
    @IBOutlet weak var vWMainSearchHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Private Variables
    private var selectedProduct : Product?
    private var refresher: CollectionViewRefresher?
    
    private var isPullToRefreshEnabled: Bool = false
    private var isScreenVisit: Bool = false
    private let viewModel = HomeViewModel(homeService: HomeService())
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Published Properties
    @Published var userSelectedCategory : Category?
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup
        setUpUI()
        
        // Set Up user Daa
        setUpUserInfo()
        
        // Set Up Collection View
        setupCollVw()
        
        // Set Up Bind Data
        bindViewModel()
        
        // Check Network Moniter
        bindInternetModel()
        
        // Set Up Search
        SetUpSearchView()
    }
    
   
}

// MARK: Button Action
extension HomeVC {
    @IBAction func actionTapUser(_ sender: Any) {
        
        // Push Profile screen
        let vc = StoryboardLoader(name: .profile).viewController(ofType: UserProfileVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionTapFilter(_ sender: Any) {
        // Push Filter screen
        let vc = StoryboardLoader(name: .filter).viewController(ofType: FilterVC.self)
        if let category = self.userSelectedCategory {
            vc.filterData = FilterEntity(category:category )
            vc.onFilterApplied = { [weak self] filterData in
                self?.getDataAfterFilerApplied(filterData:filterData)
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    fileprivate func getDataAfterFilerApplied(filterData:FilterEntity) {
        
        if let index = self.viewModel.categories.firstIndex(where: { $0.name == filterData.category.name }) {
            let indexPath = IndexPath(item: index, section: 0)
            self.collCategory.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
        self.userSelectedCategory = filterData.category
        
        self.viewModel.filterData =  filterData
        
    }
    
}

// MARK: Setup User Info
extension HomeVC {
    private func setUpUserInfo(){
        
        
        let retrievedUser : UserProfileResponse? = UserDefaultsManager.shared.loadUser()
        
        // User name
        lblUserName.text = "Hi, \(/retrievedUser?.name)"
        
        // User image
        let placeholderImg = UIImage(named: "user")
        imgUser.sd_setImage(with: URL(string: /retrievedUser?.avatar), placeholderImage: placeholderImg)
        
    }
}

// MARK: Setup Bind Data
extension HomeVC {
    private func bindInternetModel() {
        
        // Check Moniter
        NetworkMonitor.shared.connectionStatusPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isConnected in
                
                if /self?.isScreenVisit {
                    self?.showSnackBar(msg: isConnected ? "Connected to Internet" : "No Internet Connection")
                    
                    if isConnected && self?.viewModel.categories.count == 0{
                        self?.viewModel.fetchCategories()
                    }
                    else if isConnected && self?.viewModel.products.count == 0 {
                        
                        if let filter = self?.viewModel.filterData {
                            self?.viewModel.fetchProducts(with: filter)
                        }
                    }
                }else
                {self?.isScreenVisit=true}
            }
            .store(in: &cancellables)
    }
    
    private func bindViewModel() {
        
        // Check Category
        viewModel.$categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] categories in
                
                self?.userSelectedCategory = categories.first
                
                if let firstCategory = categories.first {
                    let updatedFilter  = FilterEntity(category: firstCategory)
                    self?.viewModel.filterData =  updatedFilter
                    
                    
                    self?.btnFilter.isHidden = /self?.viewModel.categories.count > 0 ? false : true
                    
                    self?.btnSearchOL.isHidden = /self?.btnFilter.isHidden
                    
                }
            }
            .store(in: &cancellables)
        
        // Check Filtered Products
        viewModel.$filteredProducts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
                // reload your product collection/table view
                //print("Products updated:", products)
                
                self?.collProducts.reloadData()
                self?.collProducts.setContentOffset(.zero, animated: true)
                
                if /self?.viewModel.isLoading == false {
                    // show/hide loader
                    self?.emptyStateView.isHidden = products.count > 0 ? true : false
                }
                
            }
            .store(in: &cancellables)
        
        // Check Error Message
        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                // Show an alert or label
                // print("Error: \(self?.error)")
                
                self?.showAlert(title: "Error", message: error.description)
                
            }
            .store(in: &cancellables)
        
        // checl Loading
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                
                if let mainView = self?.mainShimmerVw,let innerView = self?.innerShimmVw {
                    self?.ShowShimmerOrNot(isShow: self!.isPullToRefreshEnabled ? false : isLoading, vWMain: mainView , vWInner: innerView)
                    // InActive Pull to Refresh Enabled
                    self?.isPullToRefreshEnabled = false
                }
                
            }
            .store(in: &cancellables)
        
        // Check User selected Category
        $userSelectedCategory
            .receive(on: DispatchQueue.main)
            .sink { [weak self] categories in
                self?.collCategory.reloadData()
            }
            .store(in: &cancellables)
        
    }
}

// MARK: Search View
extension HomeVC {
    
    func SetUpSearchView(){
        
        self.vWMainSearch.isHidden = true
        
        self.vWSearch.layer.borderColor = ColorUtility.primaryColor.cgColor
        self.vWSearch.layer.borderWidth = 1
        self.vWSearch.layer.cornerRadius = 8
        
        
        txtFldSearch.attributedPlaceholder = NSAttributedString(
            string: "Try Searching product",
            attributes: [NSAttributedString.Key.foregroundColor: ColorUtility.secondaryColor]
        )
        
        self.collProducts.keyboardDismissMode = .onDrag;
        
        
        txtFldSearch.textPublisher
            .map { /$0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .receive(on: RunLoop.main)
            .sink { [weak self] searchText in
                
                self?.btnSearchCancel.isHidden = searchText.isEmpty
                
                self?.viewModel.searchQuery = searchText
                
                // self?.viewModel.searchQuery = searchText
            }
            .store(in: &cancellables)
    }
    
    @IBAction func actionInnerSearchCross(_ sender: Any) {
        callCrossSearchUpdateUI()
    }
    
    @IBAction func actionTapSearch(_ sender: Any) {
        
        self.btnSearchOL.isHidden = true
        setMainSearchView(hidden: false)
    }
    
    @IBAction func actionCancelSearchVw(_ sender: Any) {
        self.btnSearchOL.isHidden = false
        callCrossSearchUpdateUI()
        setMainSearchView(hidden: true)
    }
    
    
    private func setMainSearchView(hidden: Bool, animated: Bool = true) {
        
        self.vWMainSearch.isHidden = false
        
        let targetHeight: CGFloat = hidden ? 0 : 46 // Set your view’s normal height here
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.vWMainSearchHeightConstraint.constant = targetHeight
                self.vWMainSearch.alpha = hidden ? 0 : 1
                self.view.layoutIfNeeded()
            }
        } else {
            vWMainSearchHeightConstraint.constant = targetHeight
            vWMainSearch.alpha = hidden ? 0 : 1
        }
    }
    
    
    private func callCrossSearchUpdateUI() {
        self.txtFldSearch.text = ""
        self.txtFldSearch.resignFirstResponder()
        
        self.viewModel.searchQuery = ""
        self.btnSearchCancel.isHidden = true
    }
    
    
}

// MARK: Collection view Delegate & Data Source
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case collCategory:
            return CGSize(width: 80, height: 80)
        case collProducts:
            return CGSize(width: collectionView.frame.size.width/2, height: 260)
        default:
            return CGSizeZero
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collCategory:
            return self.viewModel.categories.count
        case collProducts:
            return self.viewModel.filteredProducts.count
        default:return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch collectionView {
        case collCategory:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVC", for: indexPath) as? CategoryCVC else { return UICollectionViewCell() }
            
            let category = viewModel.categories[indexPath.item]
            cell.bindCellData(category: category)
            
            cell.vWCell.backgroundColor = self.userSelectedCategory?.name == category.name ? ColorUtility.selectedCell_bgColor : ColorUtility.clr_white
            
            cell.lblTitle.font = self.userSelectedCategory?.name == category.name ? AppFont.bold.font(size: 12) : AppFont.regular.font(size: 12)
            
            return cell
        case collProducts:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCVC", for: indexPath) as? ProductCVC else { return UICollectionViewCell() }
            let product = viewModel.filteredProducts[indexPath.item]
            cell.bindCellData(product: product)
            
            
            cell.vWCell.backgroundColor = self.selectedProduct?.title == product.title ? ColorUtility.selectedCell_bgColor : ColorUtility.clr_white
            
            
            return cell
        default:return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        switch collectionView {
        case collCategory:
            let selected : Category = viewModel.categories[indexPath.item]
            userSelectedCategory = selected
            
            var updatedFilter  = self.viewModel.filterData
            updatedFilter?.category = selected
            self.viewModel.filterData =  updatedFilter
            
            
        case collProducts:
            
            let product = viewModel.filteredProducts[indexPath.item]
            
            // Selected Product
            self.selectedProduct  = product
            
            self.collProducts.reloadData()
            
            // Push home screen
            let productDetailVC: ProductDetailsVC = StoryboardLoader(name: .home).viewController(ofType: ProductDetailsVC.self)
            productDetailVC.product = product
            self.navigationController?.pushViewController(productDetailVC, animated: true)
            
        default:break
        }
        
    }
}

// Set Up
extension HomeVC {
    
    private func setUpUI(){
        
        // Hide Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.imgUser.layer.cornerRadius = self.imgUser.frame.size.height/2
        self.imgUser.clipsToBounds = true
        
        self.imgUser.contentMode = .scaleAspectFit
        
        
        refresher = CollectionViewRefresher(for: collProducts) { [weak self] in
            
            // Active Pull to Refresh Enabled
            self?.isPullToRefreshEnabled = true
            
            if let filter = self?.viewModel.filterData {
                self?.viewModel.fetchProducts(with: filter)
            }
            // End Refreshing
            self?.refresher?.endRefreshing()
        }
    }
    
    
 
    
    func setupCollVw(){
        
        self.collCategory.showsVerticalScrollIndicator = false
        self.collCategory.showsHorizontalScrollIndicator = false
        
        self.collCategory.register(UINib(nibName: "CategoryCVC", bundle: .main), forCellWithReuseIdentifier: "CategoryCVC")
        self.collCategory.collectionViewLayout.invalidateLayout()
        
        
        
        self.collProducts.showsVerticalScrollIndicator = false
        self.collProducts.showsHorizontalScrollIndicator = false
        
        self.collProducts.register(UINib(nibName: "ProductCVC", bundle: .main), forCellWithReuseIdentifier: "ProductCVC")
        
    }
    
}
