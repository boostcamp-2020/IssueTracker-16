//
//  IssueBottomSheetViewController.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/02.
//

import UIKit

class IssueBottomSheetViewController: UIViewController {
    
    // MARK: - Properties
    
    private enum State {
        case partial
        case full
    }
    private var fullViewPosition: CGFloat {
        (navigationController?.navigationBar.frame.height ?? 100) + 10
    }
    private var partialViewPosition: CGFloat {
        UIScreen.main.bounds.height - 130
    }
    private let backGroundColorGrayScale: CGFloat = {
        var grayScale: CGFloat = 0
        UIColor.systemBackground.getWhite(&grayScale, alpha: nil)
        return grayScale
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addTopShortLine()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.6, animations: {
            self.moveView(state: .partial)
        })
    }
    
    // MARK: - initialize
    
    private func configure() {
        view.backgroundColor = .systemGray6
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        view.addGestureRecognizer(gesture)
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.label.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: -3)
        view.layer.shadowRadius = 5
        let btn = UIButton(type: .system)
        btn.setTitle("TEST", for: .normal)
        btn.backgroundColor = .systemGreen
        btn.addTarget(self, action: #selector(test), for: .touchUpInside)
        self.view.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            btn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            btn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            btn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func addTopShortLine() {
        let lineWidth: CGFloat = 4
        let lineView = UIView()
        lineView.layer.cornerRadius = lineWidth / 2
        lineView.backgroundColor = .systemGray2
        self.view.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5),
            lineView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 50),
            lineView.heightAnchor.constraint(equalToConstant: lineWidth)
        ])
    }
    
    // MARK: - Methods
    
    private func moveView(state: State) {
        let yPosition = state == .partial ? partialViewPosition : fullViewPosition
        view.frame = CGRect(x: 0, y: yPosition, width: view.frame.width, height: view.frame.height)
        let grayScale = state == .partial ? backGroundColorGrayScale : 0.5
        self.parent?.view.backgroundColor = UIColor(white: grayScale, alpha: 1)
    }
    
    private func moveView(panGestureRecognizer recognizer: UIPanGestureRecognizer) {
        let transition = recognizer.translation(in: view)
        let minY = view.frame.minY
        guard (minY + transition.y >= fullViewPosition) && (minY + transition.y <= partialViewPosition) else { return }
        view.frame = CGRect(x: 0, y: minY + transition.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(CGPoint.zero, in: view)
        guard minY <= (250 + fullViewPosition) else { return }
        let grayScale = backGroundColorGrayScale == 1.0 ? (minY - fullViewPosition) / 500.0 : -1 * (minY - fullViewPosition) / 500.0
        self.parent?.view.backgroundColor = UIColor(white: grayScale + 0.5, alpha: 1)
    }
    
    // MARK: Selectors
    
    @objc private func panGesture(_ recognizer: UIPanGestureRecognizer) {
        moveView(panGestureRecognizer: recognizer)
        guard recognizer.state == .ended else { return }
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: { [weak self] in
            guard let self = self else { return }
            let state: State = self.view.frame.minY >= UIScreen.main.bounds.height / 2 ? .partial : .full
            self.moveView(state: state)
        }, completion: nil)
    }
    
    @objc private func test() {
        debugPrint("test")
    }
    
}
