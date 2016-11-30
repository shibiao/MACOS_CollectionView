//
//  ViewController.swift
//  MACOS_CollectionView
//
//  Created by sycf_ios on 2016/11/30.
//  Copyright © 2016年 sycf_ios. All rights reserved.
//

import Cocoa

class ViewController: NSViewController ,NSCollectionViewDataSource, NSTextFieldDelegate{
    //输入框
    let reuse = "reuseItem"
    var data:[String] = ["张三","李四","王五","小六"]
    var item = SBCollectionItem()
    
    @IBOutlet weak var collectionView: NSCollectionView!//colletionView
    @IBOutlet weak var inputMessages: NSTextField!//输入框
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputMessages.delegate=self
        collectionView.register(NSNib.init(nibNamed: "SBCollectionItem", bundle:nil), forItemWithIdentifier: reuse)
        //成为第一响应者
        inputMessages.becomeFirstResponder()
    }
    //点击Add按钮响应的事件
    @IBAction func add(_ sender: Any) {
        addMessages()
    }
    //添加信息
    func addMessages(){
        if !inputMessages.stringValue.isEmpty {
            data.append(inputMessages.stringValue)
            let indexPath = NSIndexPath.init(forItem: data.count-1, inSection: 0)
            collectionView.insertItems(at: [indexPath as IndexPath])
            //滚动到最底部
            collectionView.scrollToItems(at: [indexPath as IndexPath], scrollPosition: .bottom)
            //刷新最后一个item
            collectionView.reloadItems(at: [indexPath as IndexPath])
            inputMessages.stringValue=""
        }
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    //MARK: NSCollectionViewDataSource
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        item = collectionView.makeItem(withIdentifier: reuse, for: indexPath) as! SBCollectionItem
        item.nameLabel.stringValue=data[indexPath.item]
        return item
    }
    //MARK:NSTextFieldDelegate
    //按回车键即可发送内容
    override func controlTextDidEndEditing(_ obj: Notification) {
        addMessages()
    }
}

