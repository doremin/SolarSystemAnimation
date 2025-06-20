import UIKit

final class SolarSystemCAViewController: UIViewController {

    private let sunView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        view.layer.cornerRadius = 40
        view.backgroundColor = .systemYellow
        return view
    }()
    
    private lazy var earthSetup: (earthView: UIView, earthOrbitLayer: CALayer) = {
        addOrbitingBody(parentLayer: sunView.layer, centerOffset: 120, size: 30, color: .systemBlue)
    }()
    
    private lazy var moonSetup: (moonView: UIView, moonOrbitLayer: CALayer) = {
        addOrbitingBody(parentLayer: earthView.layer, centerOffset: 40, size: 12, color: .lightGray)
    }()
    
    private lazy var mercurySetup: (mercuryView: UIView, mercuryOrbitLayer: CALayer) = {
        addOrbitingBody(parentLayer: sunView.layer, centerOffset: 60, size: 20, color: .systemOrange)
    }()
    
    private var mercuryView: UIView { mercurySetup.mercuryView }
    private var mercuryOrbitLayer: CALayer { mercurySetup.mercuryOrbitLayer }
    
    private var earthView: UIView { earthSetup.earthView }
    private var earthOrbitLayer: CALayer { earthSetup.earthOrbitLayer }
    
    private var moonView: UIView { moonSetup.moonView }
    private var moonOrbitLayer: CALayer { moonSetup.moonOrbitLayer }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        sunView.center = view.center
        view.addSubview(sunView)
        _ = mercurySetup
        _ = earthSetup
        _ = moonSetup
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateSystem()
    }

    // MARK: - Add Planet
    private func addOrbitingBody(
        parentLayer: CALayer,
        centerOffset: CGFloat,
        size: CGFloat,
        color: UIColor
    ) -> (UIView, CALayer) {
        let orbitLayer = CALayer()
        orbitLayer.frame = parentLayer.bounds
        parentLayer.addSublayer(orbitLayer)

        let bodyView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        bodyView.center = CGPoint(x: orbitLayer.bounds.midX + centerOffset, y: orbitLayer.bounds.midY)
        bodyView.layer.cornerRadius = size / 3
        bodyView.backgroundColor = color

        orbitLayer.addSublayer(bodyView.layer)
        return (bodyView, orbitLayer)
    }

    // MARK: - Animation
    private func animateSystem() {
        addRotation(to: mercuryOrbitLayer, duration: 20, key: "mercuryOrbit")
        addRotation(to: earthOrbitLayer, duration: 10, key: "earthOrbit")
        addRotation(to: moonOrbitLayer, duration: 4, key: "moonOrbit")

        addRotation(to: mercuryView.layer, duration: 10, key: "mercurySpin")
        addRotation(to: earthView.layer, duration: 5, key: "earthSpin")
        addRotation(to: moonView.layer, duration: 3, key: "moonSpin")
    }
    
    private func addRotation(to layer: CALayer, duration: CFTimeInterval, key: String) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = duration
        animation.repeatCount = .infinity
        layer.add(animation, forKey: key)
    }
}
