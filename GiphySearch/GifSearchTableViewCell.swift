    //
    //  GifTableViewCell.swift
    //  GifSearch
    //
    //  Created by Hector Castillo on 5/26/22.
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
            gifImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gifImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            gifImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gifImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            gifImageView.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            gifImageView.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}
