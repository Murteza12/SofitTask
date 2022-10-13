//
//  TranforamerTableViewCell.swift
//  SofitTask
//
//  Created by Murteza on 12/10/2022.
//

import UIKit
import SDWebImage
class TranforamerTableViewCell: UITableViewCell {
    static var nib:UINib {
           return UINib(nibName: identifier, bundle: nil)
       }
       static var identifier: String {
           return String(describing: self)
       }
    @IBOutlet weak var transformerImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

    var item: Transformer? {
        didSet {
            if let imageUrl = item?.teamIcon{
                self.transformerImage.sd_setImage(with: URL(string:imageUrl), placeholderImage: nil)
                self.transformerImage.layer.cornerRadius = 12
                self.transformerImage.contentMode = .scaleToFill
                self.transformerImage.clipsToBounds = true
            }else{
                self.transformerImage.image = nil
            }
            self.nameLabel.text = item?.name
            self.detailLabel.text = "Team: \(item?.team ?? ""), endurance: \(item?.endurance ?? 0), firepower: \(item?.firepower ?? 0), rank : \(item?.rank ?? 0) skill: \(item?.skill ?? 0), speed: \(item?.speed ?? 0) , strength: \(item?.strength ?? 0)"
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
