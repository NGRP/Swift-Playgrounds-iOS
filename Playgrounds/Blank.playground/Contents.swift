import UIKit
import PlaygroundSupport
@testable import AppStoreFramework

public class ImageAndTextTableViewCell: UITableViewCell {

    // MARK: - Variables

    let stackView = UIStackView()
    let label = UILabel()
    let rightImageView = UIImageView()

    // MARK: - Lifecycle

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    private func commonInit() {

        backgroundColor = UIColor.white

        rightImageView.contentMode = .scaleAspectFit
        label.numberOfLines = 2

        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center

        stackView.spacing = 5
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(rightImageView)

        contentView.addSubview(stackView)
        contentView.anchor(view: stackView)
        contentView.backgroundColor = UIColor.red
    }
}

let frame = CGRect(x: 0, y: 0, width: 320, height: 100)

let cell = ImageAndTextTableViewCell(frame: frame)

cell.frame = frame
cell.label.text = "ceci est un texte un peu long qsdq qsd qsd q sdqsd  qs dq sd qs "
cell.label.text = "toto"

cell.rightImageView.image = UIImage(named: "image")
PlaygroundPage.current.liveView = cell


