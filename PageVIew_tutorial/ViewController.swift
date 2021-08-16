import UIKit
import FSPagerView


class ViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
  
    fileprivate let imageNames = ["1.jpeg", "2.jpeg", "3.jpeg", "4.jpeg"]
    
    
    @IBOutlet weak var leftbtn: UIButton!
    
    @IBOutlet weak var rightbtn: UIButton!
    
    
    @IBOutlet weak var mypageview: FSPagerView!{
        didSet{
            // 페이저뷰에 쎌을 등록한다.
            self.mypageview.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            // 아이템 크기 설정
            self.mypageview.itemSize = FSPagerView.automaticSize
            // 무한스크롤 설정
            self.mypageview.isInfinite = true
            // 자동 스크롤
//            self.myPagerView.automaticSlidingInterval = 4.0
        }
    }
    
    @IBOutlet weak var mypagecontrol: FSPageControl!{
        didSet{
            self.mypagecontrol.numberOfPages = self.imageNames.count
            self.mypagecontrol.contentHorizontalAlignment = .right
            self.mypagecontrol.itemSpacing = 16
            self.mypagecontrol.interitemSpacing = 16
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.mypageview.dataSource = self
        self.mypageview.delegate = self
        
        self.leftbtn.layer.cornerRadius = self.leftbtn.frame.height / 2
        self.rightbtn.layer.cornerRadius = self.rightbtn.frame.height / 2
        
            
    }

    // MARK: - IBActions
    @IBAction func onleftbtnClicked(_ sender: UIButton) {
        print("ViewContorller - onLeftBtnClicked() called")
        
        self.mypagecontrol.currentPage = self.mypagecontrol.currentPage - 1
        
        self.mypageview.scrollToItem(at: self.mypagecontrol.currentPage, animated: true)
        
    }
    
    @IBAction func onrightbtnClicked(_ sender: UIButton) {
        print("ViewController - onRightBtnClicked() called")
        
        if(self.mypagecontrol.currentPage == self.imageNames.count - 1){
            self.mypagecontrol.currentPage = 0
        } else {
            self.mypagecontrol.currentPage = self.mypagecontrol.currentPage + 1
        }
        
        self.mypageview.scrollToItem(at: self.mypagecontrol.currentPage, animated: true)
        
    }
    
    
    // MARK: - FSPagerView Datasource
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
      
    // 각 쎌에 대한 설정
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFit
        return cell
    }

    //MARK: - FSPagerView delegate
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.mypagecontrol.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.mypagecontrol.currentPage = pagerView.currentIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
}
