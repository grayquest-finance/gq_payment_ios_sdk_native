//
//  GQTimerLabel.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 29/02/24.
//

import UIKit

protocol GQTimerLabelDelegate {
    func timerCountdownCompleted(_ timer: GQTimerLabel)
}

class GQTimerLabel: UILabel {
        
    public var initialTime: Int = 180 {
        didSet {
            if !self.isTicking {
                self.seconds = initialTime
                self.text = self.timerValue
            }
        }
    }
    
    private var seconds: Int = 60

    private var timer: Timer?
    
    private var horizontalInset: CGFloat = 6
    private var verticalInset: CGFloat = 4
    
    override var isHidden: Bool {
        didSet {
            if self.isHidden {
                self.stopTimer()
            }
        }
    }
    
    lazy private var formatter = DateComponentsFormatter()
    
    private var timerValue: String? {
        let time = TimeInterval(self.seconds)
        return formatter.string(from: time)
    }
    
    public var isTicking: Bool = false
    
    public var delegate: (any GQTimerLabelDelegate)?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupFormatter()
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: verticalInset,
                                  left: horizontalInset,
                                  bottom: verticalInset,
                                  right: horizontalInset
        )
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + 2 * horizontalInset,
                      height: size.height + 2 * verticalInset)
    }

    override var bounds: CGRect {
        didSet {
            self.preferredMaxLayoutWidth = bounds.width - (2 * horizontalInset)
        }
    } 
    
    private func setupFormatter() {
        formatter.zeroFormattingBehavior = .pad
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
    }
    
    @objc private func updateTimer(_ sender: Any?) {
        guard self.seconds > 0 else {
            self.stopTimer()
            self.delegate?.timerCountdownCompleted(self)
            return
        }
        
        Task { @MainActor in
            self.seconds -= 1
            self.text = timerValue
        }
    }
    
    public func startTimer() {
        guard !self.isTicking else { return }
        self.timer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: #selector(updateTimer),
                                          userInfo: nil,
                                          repeats: true
        )
        self.isTicking = true
    }
    
    public func stopTimer() {
        timer?.invalidate()
        self.isTicking = false
    }
    
    public func resetTimer() {
        self.stopTimer()
        Task { @MainActor in
            self.seconds = initialTime
            self.text = timerValue
        }
    }
    
}
