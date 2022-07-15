//
//  BookmarkTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//
import RxRelay
import RxCocoa
import RxSwift
import SnapKit

final class BookmarkTVCell: UITableViewCell {
    private var viewModel: BookmarkTVCellViewModel?
    private let disposBag = DisposeBag()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backgourndView: UIView = {
        let view = UIView()
        view.backgroundColor = .cellBackgroundColor
        
        view.addSubview(mainStackView)
        
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView, bookMarkCollectionView])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bookmartTitle, bookmarkCount])
        
        
        return stackView
    }()
    
    private lazy var bookmartTitle: UILabel = {
        let label = UILabel()
        label.text = "즐겨찾기"
        label.font = UIFont.BlackHanSans(size: 20)
        label.textColor = .buttonColor
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        return label
    }()
    
    private lazy var bookmarkCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.one(size: 15, family: .Bold)
        label.textColor = .buttonColor
        
        return label
    }()
    
    private lazy var bookMarkCollectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .cellBackgroundColor
        collectionView.register(BookmarkCVCell.self, forCellWithReuseIdentifier: "\(BookmarkCVCell.self)")

        return collectionView
    }()

    private func setLayout() {
        self.backgroundColor = .tableViewColor
        self.contentView.addSubview(backgourndView)
        
        backgourndView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
    
    private func bindCollectionView() {
        viewModel?.bookmark
            .drive(bookMarkCollectionView.rx.items(cellIdentifier: "\(BookmarkCVCell.self)", cellType: BookmarkCVCell.self)) {[weak self] index, name, cell in
                guard let self = self else {
                    return
                }
                guard let basicInfo = self.viewModel?.searchUser(name).basicInfo else {
                    return
                }
                cell.setCell(basicInfo)
                cell.bookmarkButton.rx.tap
                    .bind(onNext: {
                        self.viewModel?.deleteBookmark(name)
                    })
                    .disposed(by: self.disposBag)
            }
            .disposed(by: disposBag)
    }
    
    func getBookmark(_ container: Container) {
        self.viewModel = container.makeBookmarkTVCellViewModel()
        viewModel?.bookmark.map { "(\($0.count))"}
            .drive(bookmarkCount.rx.text)
            .disposed(by: disposBag)
        
        bindCollectionView()
    }
}
