//
//  CollectionViewRefresher.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 26/05/25.
//


import UIKit

class CollectionViewRefresher {
    private let refreshControl = UIRefreshControl()
    private weak var collectionView: UICollectionView?
    private var onRefresh: (() -> Void)?

    init(for collectionView: UICollectionView, onRefresh: @escaping () -> Void) {
        self.collectionView = collectionView
        self.onRefresh = onRefresh

        setup()
    }

    private func setup() {
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
    }

    @objc private func handleRefresh() {
        onRefresh?()
    }

    func endRefreshing() {
        refreshControl.endRefreshing()
    }
}
