//
//  GoEuroSegmentedControl.swift
//  Goeuro
//
//  Created by Mahmoud Eldesouky on 1/15/17.
//  Copyright © 2017 Mahmoud Eldesouky. All rights reserved..
//

import UIKit

class GoEuroSegmentedControl: UIView , UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    //MARK:- HorizontalBar Constraints
    var horizontalBarCenterConstraint: NSLayoutConstraint!
    var horizontalBarWidthConstraint: NSLayoutConstraint!

    //MARK:- View Attributes
    var viewController: HomeViewController!
    var segmentOptions: Array<String>!
    var segmentOptionsWidth: Array<CGFloat>!

    let fontSize = 16.0
    var selectedIndex: Int = 0
    var segmentedControl_backgroundColor: UIColor!
    var segmentedControl_fontColor: UIColor!
    var segmentedControl_deselectCellFontColor: UIColor!
    var horizontalBarView: UIView!
    var horizontalBarHeight: CGFloat! = 4.0
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = self.segmentedControl_backgroundColor
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    
    init(frame: CGRect, options: Array<String>, backgroundColor: UIColor, fontColor: UIColor, deselectCellFontColor: UIColor){
        super.init(frame: frame)
        self.segmentOptions = options
        self.segmentedControl_backgroundColor = backgroundColor
        self.segmentedControl_fontColor = fontColor
        self.segmentedControl_deselectCellFontColor = deselectCellFontColor
        setupView()
        
    }
    
    //MARK:- SetupView
    func setupView(){
        setupSegment()
        setupHorizontalBar()
    }
    
    func setupSegment(){
        collectionView.registerClass(SegmentCell.self, forCellWithReuseIdentifier: "SegmentCell")
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
    }
    func setupHorizontalBar() {
        initHorizontalBar()
        setupHorizontalBarConstraints()
        setupHorizonatlBarInitalState()
    }
    
    //MARK:- UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmentOptions.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SegmentCell", forIndexPath: indexPath) as! SegmentCell
        cell.cellTitle.text = segmentOptions[indexPath.row]
        cell.cellTitle.textColor = self.segmentedControl_deselectCellFontColor
        cell.selectedFontColor = self.segmentedControl_fontColor
        cell.deselectedFontColor = self.segmentedControl_deselectCellFontColor
        return cell
    }
    
    //MARK:- UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        self.layoutIfNeeded()
        let cellWidth = frame.width / CGFloat(segmentOptions.count)
        return CGSize(width: cellWidth, height: frame.height)
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return 0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return 0
    }
    
    // Two things to do when a segment cell is selected:
    // -scroll views horizontally to the selected view
    // -scroll horizontal bar to the selected segment cell and adjust its width
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.didSelectBarCell(indexPath.row)
    }
    
    
    //MARK:- Helper Methods
    func initHorizontalBar(){
        horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(red: 248/255, green: 188/255, blue: 49/255, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
    }
    
    func setupHorizontalBarConstraints(){
        
        horizontalBarCenterConstraint = NSLayoutConstraint(item: horizontalBarView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: calculateHorizontalBarCenterFor(selectedIndex))
        
        let horizontalBarYConstraint = NSLayoutConstraint(item: horizontalBarView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
        
        horizontalBarWidthConstraint = NSLayoutConstraint(item: horizontalBarView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: calculateHorizontalBarWidthFor(selectedIndex))
        
        let horizontalBarHeightConstraint = NSLayoutConstraint(item: horizontalBarView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: horizontalBarHeight)
        
        self.addConstraints([horizontalBarCenterConstraint, horizontalBarYConstraint, horizontalBarWidthConstraint, horizontalBarHeightConstraint])
        
        
    }
    
    // inital segmentedControl.selectedIndex set to 0 (Trains)
    func setupHorizonatlBarInitalState(){
        didSelectBarCell(0)
    }
    
    //calculate horizontal bar centerX postion according to the selected segment text centerX
    func calculateHorizontalBarCenterFor(index: Int) -> CGFloat{
        let cellWidth = frame.width / 3
        let cellCenterXPosition = cellWidth / 2
        
        let barNewCenterXPosition = (((cellWidth * CGFloat(index)) + cellCenterXPosition) - (calculateHorizontalBarWidthFor(index) / 2))
        
        return barNewCenterXPosition
    }
    
    //calculate horizontal bar width according to the selected segment text size.width
    func calculateHorizontalBarWidthFor(index: Int) -> CGFloat{
        
        let labelText: NSString = segmentOptions[index]
        let labelFont = UIFont(name: "NeutraTextTF-DemiAlt", size: CGFloat(fontSize))!
        let textAttributes = [NSFontAttributeName: labelFont]
        let expectedLabelSize: CGRect = labelText.boundingRectWithSize(CGSizeMake(320, 2000), options: .UsesLineFragmentOrigin, attributes: textAttributes, context: nil)
        
        let calculatedBarWidth = expectedLabelSize.width
        return calculatedBarWidth
    }
    
    
    func didSelectBarCell(index: Int){
        scrollToSelectedView(index)
        scrollHorizontalBarToSelectedSegmentCell(index)
    }
    

    func scrollToSelectedView(index: Int){
        viewController?.segmentedControlValueDidChangeTo(Int32(index), fromScrollingAction: false)
    }
    func scrollHorizontalBarToSelectedSegmentCell(index: Int){
        
        let selectedIndexPath = NSIndexPath(forRow: index, inSection: 0)
        self.updateConstraints()
        self.layoutIfNeeded()
        
        if (index < segmentOptions.count && index > -1) {
            
            self.collectionView.selectItemAtIndexPath(selectedIndexPath, animated: false, scrollPosition: .CenteredHorizontally)
            self.scrollHorizontalBarTo(index)
            self.selectedIndex = index
            
        }
    }
    func scrollHorizontalBarTo(index: Int){
        
        horizontalBarCenterConstraint.constant = calculateHorizontalBarCenterFor(index)
        horizontalBarWidthConstraint.constant = calculateHorizontalBarWidthFor(index)
        
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
            self.updateConstraints()
            self.layoutIfNeeded()
            }, completion: nil)
        
    }
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}


