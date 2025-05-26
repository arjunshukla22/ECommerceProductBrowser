//
//  HomeViewModel.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 24/05/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published private(set) var categories: [Category] = []
    @Published private(set) var products: [Product] = []
    @Published private(set) var isLoading: Bool = false
    @Published var filterData: FilterEntity?
    @Published var errorMessage: String? = nil
    
    // MARK: - Private Properties
    private let homeService: HomeService
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(homeService: HomeService = HomeService()) {
        self.homeService = homeService
        setupBindings()
        fetchCategories()
    }
    
    // MARK: - Setup Bindings
    private func setupBindings() {
        $filterData
            .compactMap { $0 }
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .sink { [weak self] categoryId in
                if let filter = self?.filterData {
                    self?.fetchProducts(with: filter)
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - API: Fetch Categories
    func fetchCategories() {
        isLoading = true
        errorMessage = nil
        
        homeService.fetchCategories()
            .sink(receiveCompletion: { [weak self] completion in
               // self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = ErrorMapper.message(for: error)
                }
            }, receiveValue: { [weak self] categories in
                self?.categories = categories
                //self?.selectedCategoryId = "\(/categories.first?.id)"
            })
            .store(in: &cancellables)
    }
    
    // MARK: - API: Fetch Products
     func fetchProducts(with filter: FilterEntity) {
        isLoading = true
        errorMessage = nil
        
        homeService.fetchProducts(with: filter)
            .map { products in
                    products.sorted { $0.price < $1.price } // 👈 Sort by price ascending
                }
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = ErrorMapper.message(for: error)
                }
            }, receiveValue: { [weak self] products in
                self?.products = products
            })
            .store(in: &cancellables)
    }
}


