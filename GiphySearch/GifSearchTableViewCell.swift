    //
    //  GifTableViewCell.swift
    //  GifSearch
    //
    //  Created by  on 5/26/22.
    //

import UIKit
import FLAnimatedImage

class GifTableViewCell: UITableViewCell {
    public var gifImageView: FLAnimatedImageView = {
        let gifImageView = FLAnimatedImageView()
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        gifImageView.contentMode = .scaleAspectFit
        return gifImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        contentView.addSubview(gifImageView)

        NSLayoutConstraint.activate([
            gifImageView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            gifImageView.topAnchor.constraint(equalTo: contentView.readableContentGuide.topAnchor),
            gifImageView.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor),
            gifImageView.bottomAnchor.constraint(equalTo: contentView.readableContentGuide.bottomAnchor)
        ])
    }
}
