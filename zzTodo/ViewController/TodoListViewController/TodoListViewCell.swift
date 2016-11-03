//
//  TodoListViewCell.swift
//  zzTodo
//
//  Created by 김형운 on 2016. 10. 14..
//  Copyright © 2016년 hwkim03. All rights reserved.
//

import UIKit
import PureLayout
import Kingfisher

class TodoListViewCell: UITableViewCell {

    var checkBox: UIButton!
    var todoLabel: UILabel!
    var iconView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            self.contentView.backgroundColor = UIColor.redColor()
        } else {
            
        }
    }
    
    func commonInit() {
        self.setupSubview()
        self.setupAutoLayout()
    }
    
    func setupSubview() {
        iconView = UIImageView()
        iconView.backgroundColor = UIColor.blueColor()
        iconView.contentMode = .ScaleAspectFit
        self.contentView.addSubview(iconView)
        
//        checkBox = UIButton()
//        checkBox.backgroundColor = UIColor.orangeColor()
//        checkBox.setTitle("선택", forState: .Selected)
//        checkBox.setTitle("해제됨", forState: .Normal)
//        checkBox.setBackgroundImage(UIImage(named: "btn_add"), forState: .Normal)
//        checkBox.addTarget(self, action: #selector(self.chageCheckboxState), forControlEvents: .TouchUpInside)
//        self.contentView.addSubview(checkBox)
        
        todoLabel = UILabel(frame: CGRect(x: 5, y: 5, width: 200, height: 50))
        self.contentView.addSubview(todoLabel)
    }
    
    func setupAutoLayout() {
        iconView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(10, 10, 10, 10), excludingEdge: .Right)
        iconView.autoSetDimension(.Width, toSize: 70)
        todoLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(10, 10, 10, 10), excludingEdge: .Left)
        iconView.autoPinEdge(.Right, toEdge: .Left, ofView: todoLabel, withOffset: -10)
    }
    
    func configureForItem(item: TodoItem) {
        self.todoLabel.text = item.title
        if let imageURL = item.imageURL {
//            self.imageView?.image = UIImage(data: NSData(contentsOfURL: NSURL(string: imageURL)!)!)
//            self.iconView.kf_setImageWithURL(NSURL(string: imageURL))
            self.iconView.kf_setImageWithURL(NSURL(string: imageURL), placeholderImage: nil, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    func chageCheckboxState() {
        checkBox.selected = !checkBox.selected
    }
}
