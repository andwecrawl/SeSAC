//
//  SearchViewController.swift
//  SeSACWeek10
//
//  Created by yeoni on 2023/09/21.
//

import UIKit
import SnapKit
import Kingfisher

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    let list = ["가나다라", "해장asdasdasd국", "밥밥sdasdasd", "맛있sadasdsadasd는갈치조림", "아이asdasdadasd", "아asdasdasdsad이폰"]
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configurePinterestLayout())
    var dataSource: UICollectionViewDiffableDataSource<Int, PhotoResult>!
    // :3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureLayout()
        configureDataSource()
        
        let bar = UISearchBar()
        bar.delegate = self
        navigationItem.titleView = bar
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        Network.shared.requestConvertible(type: Photo.self, api: .search(query: text)) { response in
            switch response {
            case .success(let success):
                // 데이터를 담아주고 갱신해 줘야 할 거임 (Data + UI)
                
                let ratios = success.results.map { Ratio(ratio: $0.width / $0.height)}
                let layout = PinterestLayout(columnsCount: 2, itemRatios: ratios, spacing: 10, contentWidth: self.view.frame.width)
                // item group section code는 class 안에 숨겨둔 상태!!
                self.collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: layout.section)
                self.configureSnapshot(success.results)
                
                dump(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func configureSnapshot(_ item: [PhotoResult]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PhotoResult>()
        snapshot.appendSections([0])
        snapshot.appendItems(item)
        dataSource.apply(snapshot)
    }
    
    private func configureHierachy() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
    }
    
    private func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configurePinterestLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(100))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        
        // 수직 스크롤에 대한 대응까지는 온 상태!!
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        
        // 전체를 채워주는 이전 코드
 //       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = config
        
        return layout
        
    }
    
    
   func configureCollectionViewLayout() -> UICollectionViewLayout {
       
       let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0))
       
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
       
       let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .absolute(30))
       
       // 수직 스크롤에 대한 대응까지는 온 상태!!
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
       
       // 전체를 채워주는 이전 코드
//       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
       
       group.interItemSpacing = .fixed(10)
       
       let section = NSCollectionLayoutSection(group: group)
       section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30)
       section.interGroupSpacing = 10
       
       let config = UICollectionViewCompositionalLayoutConfiguration()
       config.scrollDirection = .vertical
       
       let layout = UICollectionViewCompositionalLayout(section: section)
       layout.configuration = config
       
       return layout
       
   }
    
    /*
     고정되어 있는 셀 사이즈 대응!!
     item /
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        
        // group 안에 셀이 들어가서 group의 사이즈를 기준으로 itemSize를 상대적으로!!!!!!! 계산해 주면 댐
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
        
        // group은 가상의 바구니이기 때문에 코드를 보고 뷰를 보고 끼워맞춰서 이해하면 조금 더 이해가 잘댐
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
        // 그룹의 높이는 80으로 고정!! => absolute는 절대적인 수치임!
        // .fractionWidth(Float) <- 1.0 디바이스 전체에 꽉차게!!
        
        // 우리 이런 그룹 컨테이너를 맹글 건데 여기 안에는 item이 3개씩 들어갈 거야!!
        // 안에 item을 수직으로 채워줄지 수평으로 채워줄지~~!!
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        // Group의 기준은 수평으로 네 개군아.
        // 이 아래 space 코드는 그럼 수평적인 space군아 ...
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30)
        // 그룹과 그룹 사이 간격도 Section이 하는군아 ㅇ,ㅇ
        section.interGroupSpacing = 50
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = config
        
        return layout
        
    }
     */
    
//    func configureCollectionViewLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 50, height: 50)
//        layout.scrollDirection = .vertical
//        return layout
//    }
    
    func configureDataSource() {
        
        // cellNib => XIB 파일!!
        // 어떤 cell을 쓸 건데? 라고 물어보는 거잉
//        어떤 셀을 쓰고 어떤 데이터를 넣을지!
        let cellRegistration = UICollectionView.CellRegistration<SearchCollectionViewCell, PhotoResult> { cell, indexPath, itemIdentifier in
            // itemIdentifier => 데이터 하나하나의 형태
            cell.imageView.kf.setImage(with: URL(string: itemIdentifier.urls.thumb)!)
            cell.label.text = "\(itemIdentifier.created_at)번"
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
        })
    }
}


/*
// scrollView
// 가운데 레이아웃을 잘 잡아주는 게!! 중요
class SearchViewController: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let imageView = UIImageView()
    let label = UILabel()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureHierarchy()
        configureLayout()
        configureContentView()
    }
    
    func configureContentView() {
        scrollView.delegate = self
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        contentView.addSubview(button)
        
        imageView.backgroundColor = .orange
        label.backgroundColor = .cyan
        button.backgroundColor = .green
        
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(contentView).inset(10)
            make.height.equalTo(200)
        }
        
        button.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView).inset(10)
            make.height.equalTo(80)
        }
        
        label.numberOfLines = 0
        label.text = "rkskekfkdkkdkddkkdkddkjksjfkjdfjsdfjsdjfsdjfksdjfksdjfksjdfkdjkfjskdjfksdjkfsjdkfjskdjfksjfksjdkfjskfjskdjfksdjfksjfkssdfasdf\nasdfsdfsdfsasdfajweo\nifwnefionvldskvna\nwecnldknzlckv\nmxlkvnioweniow\nniofwoejfois\ndjfiojasd\nlfkjasdfasdf\nasdfsdfsdfsasdfajweo\nifwnefionvldskvna\nwecnldknzlckv\nmxlkvnioweniow\nniofwoejfois\ndjfiojasd\nlfkjasdfasdf\nasdfsdfsdfsasdfajweo\nifwnefionvldskvna\nwecnldknzlckv\nmxlkvnioweniow\nniofwoejfois\ndjfiojasd\nlfkjasdfasdf\nasdfsdfsdfsasdfajweo\nifwnefionvldskvna\nwecnldknzlckv\nmxlkvnioweniow\nniofwoejfois\ndjfiojasd\nlfkja"
        label.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(10)
            make.top.equalTo(imageView.snp.bottom).offset(50)
            make.bottom.equalTo(button.snp.top).offset(-50)
        }
    }
    
    func configureHierarchy() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .lightGray
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        print(scrollView.contentOffset.y)
        
        if scrollView.contentOffset.y >= 50 {
            // label.alpha나 변화주고 싶은 걸 넣어주면 대는 거임
        }
    }
    
}
*/

// stackView
/*
class SearchViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureHierarchy()
        setLayout()
        configureStackView()
    }
    
    
    func configureHierarchy() {
        scrollView.backgroundColor = .lightGray
        stackView.spacing = 16
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
    }
    
    
    func setLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(70)
        }
        
        stackView.backgroundColor = .black
        stackView.snp.makeConstraints { make in
            make.edges.height.equalTo(scrollView)
        }
    }
    
    func configureStackView() {
        let firstLabel = UILabel()
        firstLabel.text = "안녕하세요?"
        firstLabel.backgroundColor = .systemBlue
        firstLabel.textColor = .white
        stackView.addArrangedSubview(firstLabel)
        
        let secondLabel = UILabel()
        secondLabel.text = "졸리신ㄴㅇㅁㄴㅇㅁ가요?"
        secondLabel.textColor = .white
        secondLabel.backgroundColor = .systemGreen
        stackView.addArrangedSubview(secondLabel)
        
        let thirdLabel = UILabel()
        thirdLabel.text = "배고ㅁㄴㅇㅁㄴㅇ파용"
        thirdLabel.textColor = .white
        thirdLabel.backgroundColor = .systemRed
        stackView.addArrangedSubview(thirdLabel)
        
        let fourthLabel = UILabel()
        fourthLabel.text = "목말라ㅁㄴㅇㅁㄴㅇ용"
        fourthLabel.textColor = .white
        fourthLabel.backgroundColor = .systemYellow
        stackView.addArrangedSubview(fourthLabel)
        
        let fifthLabel = UILabel()
        fifthLabel.text = "졸ㅁㄴㅇㅁㄴㅇㅁㄴㅇㄴㅁㅇㄴㅁㅇ려용"
        fifthLabel.textColor = .white
        fifthLabel.backgroundColor = .systemPink
        stackView.addArrangedSubview(fifthLabel)
    }
    
}
*/
