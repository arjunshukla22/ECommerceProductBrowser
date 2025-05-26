//
//  FilterVC.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 25/05/25.
//

import UIKit
import Combine
import RangeSeekSlider

struct FilterEntity {
    
    var category : Category
    var minValue : Int
    var maxValue : Int
    
    init(category: Category, minValue: Int = 10 , maxValue: Int = 500) {
        self.category = category
        self.minValue = minValue
        self.maxValue = maxValue
    }
}


class FilterVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var vWCategoryDropDown: UIView!
    @IBOutlet fileprivate weak var rangeSliderCurrency: RangeSeekSlider!
    
    // MARK: - Variables
    var filterData : FilterEntity?
    var onFilterApplied: ((_ filterData: FilterEntity) -> Void)?
    
    private let viewModel = HomeViewModel(homeService: HomeService())
    private var cancellables = Set<AnyCancellable>()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Basic Set Up
        setUpUI()
        
        // range Slider
        setUpRangeSlider()
        
        // View models Observer
        bindViewModel()
    }
    
    
    fileprivate func setUpUI() {
        self.btnReset.layer.cornerRadius = UIConstants.Button.cornerRadius
        
        self.btnReset.layer.borderColor = ColorUtility.borderColor.cgColor
        self.btnReset.layer.borderWidth = UIConstants.View.borderWidth
        self.btnApply.layer.cornerRadius = UIConstants.Button.cornerRadius
        
        vWCategoryDropDown.setBorder(cornerRadius: UIConstants.CornerRadius.medium,
                                     borderWidth: UIConstants.View.borderWidth,
                                     borderColor: ColorUtility.borderColor)
        
        self.lblCategoryName.text = /self.filterData?.category.name
    }
    
    
    fileprivate func bindViewModel() {
        viewModel.$categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                
            }
            .store(in: &cancellables)
    }
}

// MARK: - Show Category Pop up
extension FilterVC {
    
    @IBAction func actionTapCategoryDropDown(_ sender: Any) {
        self.ShowCategoryDropDown()
    }

    private func ShowCategoryDropDown() {
        
        // Load GenricTablePopup from XIB
        guard let categoryView = GenricTablePopup().loadNib() as? GenricTablePopup else {
            return
        }
        
        categoryView.selectedCategory = filterData?.category
        
        // Set the data
        categoryView.SetContentData(data: self.viewModel.categories)
        
        // Handle button tap callback
        categoryView.callBackForSelect = { [weak self] category in
            self?.lblCategoryName.text = /category.name
            
            self?.filterData?.category = category
        }
        
        // Show popup with animation
        DragAndDropMethods.showView(withAnimation: categoryView, heightOfView: 0, popUpview: categoryView.vwPopup)
        
        // Add popup to the app window
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.addSubview(categoryView)
        }
        
        
    }



}


// MARK: - Action button
extension FilterVC {
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionApply(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
        if let filterData = filterData {
            onFilterApplied?(filterData)
        }
        
    }
    
    @IBAction func actionReset(_ sender: Any) {
        
        if let defaultCategory = self.viewModel.categories.first {
            filterData = FilterEntity(category: defaultCategory)
            
            self.lblCategoryName.text = /defaultCategory.name
        }
        rangeSliderCurrency.selectedMinValue = 10.0
        rangeSliderCurrency.selectedMaxValue = 500.0
        
        rangeSliderCurrency.setNeedsLayout()
    }
}

// MARK: - RangeSeekSliderDelegate

extension FilterVC: RangeSeekSliderDelegate {
    
    private func setUpRangeSlider() {
        
        // currency range slider
        rangeSliderCurrency.delegate = self
        rangeSliderCurrency.minValue = 10.0
        rangeSliderCurrency.maxValue = 2000.0
        rangeSliderCurrency.selectedMinValue = 10.0
        rangeSliderCurrency.selectedMaxValue = 500.0
        rangeSliderCurrency.minDistance = 20.0
        rangeSliderCurrency.maxDistance = 2200.0
        rangeSliderCurrency.handleColor = ColorUtility.primaryColor
        rangeSliderCurrency.handleDiameter = 30.0
        rangeSliderCurrency.selectedHandleDiameterMultiplier = 1.3
        rangeSliderCurrency.numberFormatter.numberStyle = .currency
        rangeSliderCurrency.numberFormatter.locale = Locale(identifier: "en_US")
        rangeSliderCurrency.numberFormatter.maximumFractionDigits = 0
        rangeSliderCurrency.minLabelFont = AppFont.bold.font(size: 15.0)
        rangeSliderCurrency.maxLabelFont = AppFont.bold.font(size: 15.0)
        
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider === rangeSliderCurrency {
            filterData?.minValue = Int(minValue)
            filterData?.maxValue = Int(maxValue)
        }
    }
    
    func didStartTouches(in slider: RangeSeekSlider) {}
    func didEndTouches(in slider: RangeSeekSlider) {}
}
