import UIKit

final class SolarSystemViewController: UIViewController {

    private var displayLink: CADisplayLink?
    private var earthAngle: CGFloat = 0
    private var moonAngle: CGFloat = 0

    private let sunView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        view.layer.cornerRadius = 40
        view.backgroundColor = .systemYellow
        return view
    }()
    
    private lazy var earthView: UIView = {
        addOrbitingBody(parentView: view, centerOffset: 120, size: 30, color: .systemBlue)
    }()
    
    private lazy var moonView: UIView = {
        addOrbitingBody(parentView: view, centerOffset: 40, size: 12, color: .lightGray)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        sunView.center = view.center
        view.addSubview(sunView)
        _ = earthView
        _ = moonView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startOrbit()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        displayLink?.invalidate()
        displayLink = nil
    }

    // MARK: - Add Planet
    private func addOrbitingBody(
        parentView: UIView,
        centerOffset: CGFloat,
        size: CGFloat,
        color: UIColor
    ) -> UIView {
        let bodyView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        bodyView.center = CGPoint(x: parentView.bounds.midX, y: parentView.bounds.midY)
        bodyView.layer.cornerRadius = size / 3
        bodyView.backgroundColor = color
        parentView.addSubview(bodyView)
        return bodyView
    }

    // MARK: - Animation
    private func startOrbit() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateOrbit))
        displayLink?.add(to: .main, forMode: .default)
    }

    @objc private func updateOrbit() {
        let earthSpeed: CGFloat = .pi / 180
        let moonSpeed: CGFloat = .pi / 90

        earthAngle += earthSpeed
        moonAngle += moonSpeed

        let earthRadius: CGFloat = 120
        let moonRadius: CGFloat = 40

        let earthX = cos(earthAngle) * earthRadius
        let earthY = sin(earthAngle) * earthRadius

        let earthTransform = CGAffineTransform.identity
            .rotated(by: earthAngle)
            .translatedBy(x: earthX, y: earthY)
        earthView.transform = earthTransform

        let moonX = cos(moonAngle) * moonRadius
        let moonY = sin(moonAngle) * moonRadius

        let moonTransform = earthTransform
            .rotated(by: moonAngle)
            .translatedBy(x: moonX, y: moonY)
        moonView.transform = moonTransform
    }
}
