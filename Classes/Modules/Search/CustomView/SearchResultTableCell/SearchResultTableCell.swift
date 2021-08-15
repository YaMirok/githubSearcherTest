//
// Created by Damir Sitdikov on 15.08.2021.
//

import UIKit
import SnapKit

final class SearchResultTableCell: UITableViewCell {
    var model: SearchResultTableCellModel!

    // MARK: - UI Components

    private(set) lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Themed.black
        label.font = .Bold.system14
        label.numberOfLines = 0
        return label
    }()

    private(set) lazy var updatedAtLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .Regular.system12
        return label
    }()

    private(set) lazy var starsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .Regular.system12
        return label
    }()

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        separatorInset = .init(top: 0, left: 12, bottom: 0, right: 0)
        addSubviews()
        makeConstraints()
    }

    private func addSubviews() {
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(updatedAtLabel)
        contentStackView.addArrangedSubview(starsCountLabel)
    }

    private func makeConstraints() {
        contentStackView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(12)
            maker.top.bottom.equalToSuperview().inset(16)
        }
    }

}

extension SearchResultTableCell {
    func configure(_ model: SearchResultTableCellModel) {
        self.model = model
        titleLabel.text = model.title
        updatedAtLabel.text = "Updated at: " + (model.updatedAtString ?? "")
        starsCountLabel.text = "Stars count: \(model.starsCount) " + "★"
    }
}
