//
//  ViewController.swift
//  SnapshotTestsExample
//
//  Created by Harshad Dange on 04/10/2021.
//

import UIKit

class ViewController: UIViewController {

    let slider: UISlider = {
        let slider = UISlider()
        slider.value = 5
        slider.minimumValue = 0
        slider.maximumValue = 20
        slider.accessibilityIdentifier = "slider"
        return slider
    }()

    let label: UILabel = {
        let label = UILabel()
        label.text = "5.00"
        label.textAlignment = .center
        label.accessibilityIdentifier = "label"
        return label
    }()

    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        return button
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 32
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupActions()
    }

    @objc func sliderValueChanged() {
        label.text = String(format: "%.2f", slider.value)
    }

    @objc func tapReset() {
        slider.value = 5
        sliderValueChanged()
    }

    private func setupViews() {
        view.backgroundColor = .white
        title = "Snapshot Tests"

        [label, slider, button]
            .forEach(stackView.addArrangedSubview(_:))

        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        [
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
            .forEach(view.addConstraint(_:))
    }

    private func setupActions() {
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        button.addTarget(self, action: #selector(tapReset), for: .touchUpInside)
    }
}
